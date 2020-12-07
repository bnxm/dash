import 'package:shared/shared.dart';

class Location extends Equatable {
  final LatLng latLng;
  final DateTime time;
  final double velocity;
  final double altitude;
  const Location({
    required this.latLng,
    required this.time,
    this.velocity = 0.0,
    this.altitude = 0.0,
  });

  @override
  List<Object> get props => [latLng, time, velocity, altitude];
}
