import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'package:dash/data/data.dart';

export 'package:background_location/background_location.dart' show Priority;

abstract class LocationProvider {
  factory LocationProvider() => di<LocationProviderImpl>();

  Future<bool> get isServiceEnabled;
  Future<PermissionStatus> get status;

  Future<PermissionStatus> requestPermission();
  Future<bool> enableService();

  Stream<MetricalLocation> get stream;

  bool get isRunning;

  void start({
    Priority priority = Priority.balancedPowerAccuracy,
    Duration interval = const Seconds(5),
  });

  void stop();

  void setNotification({
    String title = '',
    String text = '',
    String summary = '',
    String icon = '',
    Color color = Colors.red,
    List<NotificationAction> actions = const [],
  });
}

class LocationProviderImpl implements LocationProvider {
  final BackgroundLocation location;
  LocationProviderImpl(
    this.location,
  );

  @override
  Future<PermissionStatus> get status => location.getPermissionStatus();

  @override
  Future<PermissionStatus> requestPermission() => location.requestPermission();

  @override
  Future<bool> get isServiceEnabled => location.getServiceStatus().isEnabled;

  @override
  Future<bool> enableService() => location.requestService().isEnabled;

  @override
  bool get isRunning => location.isRunning;

  @override
  void start({
    Priority priority = Priority.balancedPowerAccuracy,
    Duration interval = const Seconds(5),
  }) {
    location.start(
      spec: RequestSpec(
        interval: interval,
        priority: priority,
      ),
    );
  }

  @override
  void stop() => location.stop();

  @override
  void setNotification({
    String title = '',
    String text = '',
    String summary = '',
    String icon = '',
    Color color = Colors.red,
    List<NotificationAction> actions = const [],
  }) {
    location.setNotification(
      NotificationSpec(
        title: title,
        text: text,
        summary: summary,
        icon: icon,
        color: color,
        actions: actions,
      ),
    );
  }

  @override
  Stream<MetricalLocation> get stream {
    return location.stream.map(
      (location) => MetricalLocation(
        latLng: LatLng(location.latitude, location.longitude),
        altitudeMeters: location.altitude,
        velocityKph: location.velocity,
        time: location.time,
      ),
    );
  }
}
