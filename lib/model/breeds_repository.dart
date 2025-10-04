import 'package:flutter_cat_breeds/domain/breed.dart';
import 'package:flutter_cat_breeds/model/breeds_request_setting.dart';
import 'package:flutter_cat_breeds/util/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../_generated/model/breeds_repository.g.dart';

class QiitaListException implements Exception {}

abstract class BreedstRepositoryInterface {
  Future<List<Breed>> fetchBreeds();
}

final class BreedsRepository implements BreedstRepositoryInterface {
  @override
  Future<List<Breed>> fetchBreeds() async {
    return HttpClient().request(setting: BreedsRequestSetting());
  }
}

@riverpod
BreedsRepository breedsRepository(BreedsRepositoryRef ref) {
  return BreedsRepository();
}
