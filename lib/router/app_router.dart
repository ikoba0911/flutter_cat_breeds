import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/router/app_route_name.dart';
import 'package:flutter_cat_breeds/view/home/home_screen.dart';
import 'package:flutter_cat_breeds/domain/breed.dart';
import 'package:flutter_cat_breeds/view/detail/detail_screen.dart';

final class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget builder;

    switch (settings.name) {
      case AppRouteName.home:
        builder = const HomeScreen();
        break;

      case AppRouteName.detail:
        final args = settings.arguments;
        if (args is Breed) {
          builder = DetailScreen(breed: args);
        } else {
          builder = const Center(
            child: Text(
              'Routing error: AppRouteName.detail には Breed 型の arguments が必要です',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

      default:
        builder = const Center(
          child: Text(
            'undefined route',
            style: TextStyle(color: Colors.red),
          ),
        );
        break;
    }

    return MaterialPageRoute(
      builder: (_) => builder,
      settings:
          RouteSettings(name: settings.name, arguments: settings.arguments),
    );
  }
}
