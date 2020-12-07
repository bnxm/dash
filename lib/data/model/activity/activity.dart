import 'package:shared/shared.dart';

import 'package:dash/domain/domain.dart';

import 'location.dart';

export 'location.dart';

class MetricalActivity extends Activity {
  final List<List<MetricalLocation>> metNodes;
  MetricalActivity({
    ActivityType type = ActivityType.run,
    Duration duration = Duration.zero,
    List<List<MetricalLocation>> nodes = const [],
  })  : metNodes = nodes,
        super(
          type: type,
          nodes: nodes,
          activeDuration: duration,
          restDuration: _restDuration(nodes),
          distance: _totalDistance(nodes),
        );

  static double _totalDistance(List<List<MetricalLocation>> nodes) {
    return nodes.sumBy((streak) {
      var subDistance = 0.0;

      for (var i = 1; i < streak.length; i++) {
        final prev = streak[i - 1];
        final curr = streak[i];

        subDistance += curr.latLng.distanceTo(prev.latLng);
      }

      return subDistance;
    });
  }

  static Duration _restDuration(List<List<MetricalLocation>> nodes) {
    if (nodes.length <= 1) return Duration.zero;

    Duration result = Duration.zero;
    for (var i = 1; i < nodes.length; i++) {
      final prev = nodes[i - 1];
      final curr = nodes[i];
      if (prev.isEmpty || curr.isEmpty) continue;

      result += curr.first.time.difference(prev.last.time);
    }

    return result;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.id,
      'duration': activeDuration.inMilliseconds,
      'nodes': metNodes.map((streak) => streak.map((l) => l.toMap())).toList(),
    };
  }

  MetricalActivity fromMap(Map<String, dynamic> map) {
    return MetricalActivity(
      duration: Millis(map['duration'] ?? 0),
      type: ActivityType.values.firstWhere(
        (type) => type.id == map['type'],
        orElse: () => ActivityType.run,
      ),
      nodes: List<List<MetricalLocation>>.from(
        map['nodes'].map(
          (streak) => List<MetricalLocation>.from(
            streak.map((l) => MetricalLocation.fromMap(l)),
          ),
        ),
      ),
    );
  }
}
