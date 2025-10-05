import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/router/app_route_name.dart';
import 'package:flutter_cat_breeds/router/app_router.dart';
import 'package:flutter_cat_breeds/view/home/home_screen.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter',
      home: HomeScreen(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouteName.home,
    );
  }
}
