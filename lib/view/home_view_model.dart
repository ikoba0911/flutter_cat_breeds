import 'package:flutter_cat_breeds/domain/breed.dart';
import 'package:flutter_cat_breeds/model/breeds_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../_generated/view/home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<List<Breed>> build() {
    final repo = ref.read(breedsRepositoryProvider);
    state = const AsyncLoading();
    return repo.fetchBreeds();
  }

  Future<void> fetch() async {
    final repo = ref.read(breedsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.fetchBreeds());
  }
}
