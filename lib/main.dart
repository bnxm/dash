import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'injection.dart';
import 'ui/ui.dart';

void main() async {
  await inject();
  runApp(Dash());
}

class Dash extends StatelessWidget {
  static final List<AppTheme> themes = [
    lightTheme,
    blackTheme,
  ];

  @override
  Widget build(BuildContext context) {
    return MyApp(
      title: 'Dash',
      home: Home(),
      splashScreen: Container(),
      themes: themes,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
