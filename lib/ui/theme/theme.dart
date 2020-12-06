import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

export 'black_theme.dart';
export 'light_theme.dart';

class DashSchema extends Schema {
  final Color positiveChange;
  final Color negativeChange;
  const DashSchema({
    required Color dividerColor,
    required Color onSurfaceLight,
    required Color onSurfaceDark,
    required Color splashColor,
    required Color focusColor,
    required Color hoverColor,
    required Color highlightColor,
    required Color primary,
    required Color primaryVariant,
    required Color secondary,
    required Color secondaryVariant,
    required Color surface,
    required Color background,
    required Color error,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
    required Color onError,
    required Brightness brightness,
    required this.positiveChange,
    required this.negativeChange,
  }) : super(
          dividerColor: dividerColor,
          onSurfaceLight: onSurfaceLight,
          onSurfaceDark: onSurfaceDark,
          splashColor: splashColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          primary: primary,
          primaryVariant: primaryVariant,
          secondary: secondary,
          secondaryVariant: secondaryVariant,
          surface: surface,
          background: background,
          error: error,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onError: onError,
          brightness: brightness,
        );

  static DashSchema of(BuildContext context) {
    return Schema.of(context) as DashSchema;
  }
}
