import 'package:shared/shared.dart';

class Node extends Equatable {
  final LatLng latLng;
  final DateTime time;
  final double velocity;
  final double altitude;
  const Node({
    required this.latLng,
    required this.time,
    required this.velocity,
    required this.altitude,
  });

  @override
  List<Object> get props => [latLng, time, velocity, altitude];
}
