import 'package:flutter/material.dart';
import 'package:flutter_cat_breeds/router/app_route_name.dart';
import 'package:flutter_cat_breeds/view/home/home_view_model.dart';
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
              return _ContentCard(
                title: breeds[index].breed,
                onTap: () => Navigator.of(context).pushNamed(
                  AppRouteName.detail,
                  arguments: breeds[index],
                ),
              );
            },
          );
        },
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('An error occurred'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(homeViewModelProvider);
                },
                child: const Text('Retry'),
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

final class _ContentCard extends StatelessWidget {
  const _ContentCard({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
