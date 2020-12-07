import 'package:shared/shared.dart';

import 'activity_type.dart';
import 'location.dart';

export 'activity_type.dart';
export 'location.dart';

class Activity extends Equatable {
  final Duration activeDuration;
  final Duration restDuration;
  final ActivityType type;
  final List<List<Location>> nodes;
  final double distance;
  const Activity({
    this.activeDuration = Duration.zero,
    this.restDuration = Duration.zero,
    this.type = ActivityType.run,
    this.nodes = const [],
    this.distance = 0.0,
  });

  DateTime get time => nodes.firstOrNull?.firstOrNull?.time ?? DateTime.now();

  @override
  List<Object> get props => [type, nodes];
}
