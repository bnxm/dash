import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';

import 'theme.dart';

final DashSchema _schema = DashSchema(
  positiveChange: Color(0xFF178876),
  negativeChange: Colors.red,
  // * Schema
  brightness: Brightness.light,
  surface: Colors.white,
  background: Colors.white,
  onPrimary: Colors.white,
  primary: const Color(0xFF184EA4),
  primaryVariant: const Color(0xFF184EA4),
  onSecondary: Colors.white,
  secondary: const Color(0xFF01C2A5),
  secondaryVariant: const Color(0xFF01C2A5),
  onSurface: Colors.grey.shade600,
  onSurfaceDark: Colors.black,
  onSurfaceLight: Colors.grey.shade400,
  dividerColor: Colors.grey.shade300,
  error: Colors.red.shade700,
  splashColor: Colors.black.withOpacity(0.05),
  focusColor: Colors.black.withOpacity(0.1),
  highlightColor: Colors.black.withOpacity(0.1),
  hoverColor: Colors.black.withOpacity(0.025),
  onError: Colors.white,
);

const SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
);

final ThemeData _themeData = ThemeFactory.create(
  schema: _schema,
  fontFamily: 'Montserrat',
);

final AppTheme lightTheme = AppTheme(
  key: 'LIGHT_THEME',
  schema: _schema,
  themeData: _themeData,
  uiOverlayStyle: _overlayStyle,
);
