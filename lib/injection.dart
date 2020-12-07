import 'package:background_location/background_location.dart';
import 'package:shared/shared.dart';

import 'core/core.dart';
import 'data/data.dart';
import 'domain/domain.dart';

Future<void> inject() async {
  // * Core
  di.lazy<LocationProvider>(() => LocationProviderImpl(BackgroundLocation()));
}
