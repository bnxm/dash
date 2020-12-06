import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';

import 'theme.dart';

final DashSchema _schema = DashSchema(
  positiveChange: Color(0xFF20B49D),
  negativeChange: Colors.redAccent,
  // * Schema
  brightness: Brightness.dark,
  surface: Colors.black.lighten(0.1),
  background: Colors.black,
  onPrimary: Colors.white,
  primary: const Color(0xFF1973EC),
  primaryVariant: const Color(0xFF1973EC),
  onSecondary: Colors.white,
  secondary: const Color(0xFF00C7A7),
  secondaryVariant: const Color(0xFF00C7A7),
  onSurface: Colors.grey.shade300,
  onSurfaceDark: Colors.white,
  onSurfaceLight: Colors.grey.shade300,
  dividerColor: Colors.grey.shade600,
  error: Colors.red.shade700,
  splashColor: Colors.white.withOpacity(0.05),
  focusColor: Colors.white.withOpacity(0.1),
  highlightColor: Colors.white.withOpacity(0.1),
  hoverColor: Colors.white.withOpacity(0.025),
  onError: Colors.white,
);

const SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.black,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);

final ThemeData _themeData = ThemeFactory.create(
  schema: _schema,
  fontFamily: 'Montserrat',
).copyWith(
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade800,
    thickness: 1.5,
    space: 0.0,
  ),
);

final AppTheme blackTheme = AppTheme(
  key: 'BLACK_THEME',
  schema: _schema,
  themeData: _themeData,
  uiOverlayStyle: _overlayStyle,
);
