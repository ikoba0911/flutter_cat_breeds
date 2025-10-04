import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/domain/breed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // 表示用のデモデータ
  final breeds = [
    const Breed(
      breed: 'breed1',
      country: 'country',
      origin: 'origin',
      coat: 'coat',
      pattern: 'pattern',
    ),
    const Breed(
      breed: 'breed2',
      country: 'country',
      origin: 'origin',
      coat: 'coat',
      pattern: 'pattern',
    ),
    const Breed(
      breed: 'breed3',
      country: 'country',
      origin: 'origin',
      coat: 'coat',
      pattern: 'pattern',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Breeds'),
      ),
      body: ListView.builder(
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          final breed = breeds[index];
          return ListTile(
            title: Text(breed.breed),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${breed.breed} tapped')),
              );
            },
          );
        },
      ),
    );
  }
}
