import 'package:shared/shared.dart';

import 'node.dart';

class Activity extends Equatable {
  final Duration activeDuration;
  final ActivityType type;
  final List<List<Node>> nodes;
  const Activity({
    this.activeDuration = Duration.zero,
    this.type = ActivityType.run,
    this.nodes = const [],
  });

  DateTime get time => nodes.firstOrNull?.firstOrNull?.time ?? DateTime.now();

  double get distance {
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

  Duration get totalRestDuration {
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

  @override
  List<Object> get props => [type, nodes];
}

enum ActivityType {
  run,
  cycle,
  hike,
}
