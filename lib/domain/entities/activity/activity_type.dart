enum ActivityType {
  run,
  cycle,
  hike,
}

extension ActivityTypeExtensions on ActivityType {
  String get id {
    switch (this) {
      case ActivityType.run:
        return 'run';
      case ActivityType.cycle:
        return 'cycle';
      case ActivityType.hike:
        return 'hike';
    }
  }
}
