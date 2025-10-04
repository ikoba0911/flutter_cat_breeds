import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/view/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

final class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: state.when(
        data: (breeds) {
          return ListView.builder(
            itemCount: breeds.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(breeds[index].breed),
                ),
              );
            },
          );
        },
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('エラーが発生しました'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(homeViewModelProvider);
                },
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
