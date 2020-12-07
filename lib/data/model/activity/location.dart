import 'package:shared/shared.dart';

import 'package:dash/domain/domain.dart';

class MetricalLocation extends Location {
  final double altitudeMeters;
  final double velocityKph;
  const MetricalLocation({
    required LatLng latLng,
    required DateTime time,
    required this.velocityKph,
    required this.altitudeMeters,
  }) : super(
          latLng: latLng,
          time: time,
          velocity: velocityKph,
          altitude: altitudeMeters,
        );

  Map<String, dynamic> toMap() {
    return {
      'latLng': latLng.toMap(),
      'time': time.microsecondsSinceEpoch,
      'velocity': velocityKph,
      'altitude': altitudeMeters,
    };
  }

  factory MetricalLocation.fromMap(Map<String, dynamic> map) {
    return MetricalLocation(
      latLng: LatLng.fromMap(map['latLng']),
      velocityKph: map['velocity'] ?? 0.0,
      altitudeMeters: map['altitude'] ?? 0.0,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] ?? 0, isUtc: true).toLocal(),
    );
  }
}
