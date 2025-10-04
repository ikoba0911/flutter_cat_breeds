import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/model/breeds_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

final class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      final repo = ref.read(breedListRepositoryProvider);
      final list = await repo.fetchBreeds();
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
