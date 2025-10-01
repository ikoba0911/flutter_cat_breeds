import 'package:freezed_annotation/freezed_annotation.dart';

part '../_generated/model/cat_breeds_response.freezed.dart';
part '../_generated/model/cat_breeds_response.g.dart';

@freezed
class BreedsResponse with _$BreedsResponse {
  const factory BreedsResponse({
    @JsonKey(name: 'data') required List<Breed> data,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'links') required List<PageLink> links,
  }) = _BreedsResponse;

  factory BreedsResponse.fromJson(Map<String, dynamic> json) =>
      _$BreedsResponseFromJson(json);
}

@freezed
class Breed with _$Breed {
  const factory Breed({
    @JsonKey(name: 'breed') required String breed,
    @JsonKey(name: 'country') required String country,
    @JsonKey(name: 'origin') required String origin,
    @JsonKey(name: 'coat') required String coat,
    @JsonKey(name: 'pattern') required String pattern,
  }) = _Breed;

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
}

@freezed
class PageLink with _$PageLink {
  const factory PageLink({
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'active') required bool active,
  }) = _PageLink;

  factory PageLink.fromJson(Map<String, dynamic> json) =>
      _$PageLinkFromJson(json);
}
