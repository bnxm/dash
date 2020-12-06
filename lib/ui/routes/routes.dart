import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

abstract class Routes {
  // ---

  static Route<T> _buildRoute<T>(Widget page) {
    return DashPageRoute<T>(
      page: page,
      duration: const Millis(600),
    );
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static NavigatorState get navigator => navigatorKey.currentState!;

  static Future<T?> push<T>(dynamic page) {
    return navigator.push(
      page is Route<T> ? page : _buildRoute(page),
    );
  }

  static Future<T?> pushAndClearStack<T>(dynamic page) {
    return navigator.pushAndRemoveUntil(
      page is Route<T> ? page : _buildRoute(page),
      (route) => false,
    );
  }

  static Future<T?> pushNamed<T>(String name, [dynamic arguments]) {
    return navigator.pushNamed<T>(
      name,
      arguments: arguments,
    );
  }

  static Future<void> pushNamedAndClear(String name, [dynamic arguments]) {
    return navigator.pushNamedAndRemoveUntil(
      name,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T>([T? result]) => navigator.pop<T>(result);
}

class DashPageRoute<T> extends MaterialPageRoute<T> {
  final Widget page;
  final Duration duration;
  DashPageRoute({
    required this.page,
    required this.duration,
  }) : super(
          builder: (_) => page,
        );

  @override
  Duration get transitionDuration => duration;
}
