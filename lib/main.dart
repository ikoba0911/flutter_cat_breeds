import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/model/cat_breeds_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final repo = BreedsRepository();
  @override
  void initState() {
    super.initState();
    Future(() async {
      final list = await repo.getBreeds();
      for (final entry in list.asMap().entries) {
        final index = entry.key; // インデックス
        final element = entry.value; // 要素

        log('$index: ${element.breed}');
        log('$index: ${element.country}');
        log('$index: ${element.origin}');
        log('$index: ${element.coat}');
        log('$index: ${element.pattern}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
