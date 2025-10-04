import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/router/app_route_name.dart';
import 'package:flutter_cat_breeds/view/home_screen.dart';

// App global navigator key.
// Used to return from the bottom sheet to the root navigator.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget builder;

    switch (settings.name) {
      case AppRouteName.home:
        builder = const HomeScreen();
      default:
        builder = const Center(
          child: Text(
            'undifined root',
            style: TextStyle(color: Colors.red),
          ),
        );
        break;
    }

    return MaterialPageRoute(
      builder: (_) => builder,
      settings: RouteSettings(name: settings.name),
    );
  }
}
