import 'package:flutter_cat_breeds/domain/breed.dart';
import 'package:flutter_cat_breeds/model/breeds_request_setting.dart';
import 'package:flutter_cat_breeds/util/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../_generated/model/breeds_repository.g.dart';

class QiitaListException implements Exception {}

abstract class BreedListRepositoryInterface {
  Future<List<Breed>> fetchBreeds();
}

final class BreedListRepository implements BreedListRepositoryInterface {
  @override
  Future<List<Breed>> fetchBreeds() async {
    return HttpClient().request(setting: BreedsRequestSetting());
  }
}

@riverpod
BreedListRepository breedListRepository(BreedListRepositoryRef ref) {
  return BreedListRepository();
}
