import 'package:freezed_annotation/freezed_annotation.dart';

part '../_generated/domain/breed.freezed.dart';

@freezed
class Breed with _$Breed {
  const factory Breed({
    required String breed,
    required String country,
    required String origin,
    required String coat,
    required String pattern,
  }) = _Breed;
}
