import 'package:freezed_annotation/freezed_annotation.dart';

part '../_generated/model/breeds_response.freezed.dart';
part '../_generated/model/breeds_response.g.dart';

@freezed
class BreedsResponse with _$BreedsResponse {
  const factory BreedsResponse({
    @JsonKey(name: 'data') required List<BreedResponse> data,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'links') required List<PageLinkResponse> links,
  }) = _BreedsResponse;

  factory BreedsResponse.fromJson(Map<String, dynamic> json) =>
      _$BreedsResponseFromJson(json);
}

@freezed
class BreedResponse with _$BreedResponse {
  const factory BreedResponse({
    @JsonKey(name: 'breed') required String breed,
    @JsonKey(name: 'country') required String country,
    @JsonKey(name: 'origin') required String origin,
    @JsonKey(name: 'coat') required String coat,
    @JsonKey(name: 'pattern') required String pattern,
  }) = _BreedResponse;

  factory BreedResponse.fromJson(Map<String, dynamic> json) =>
      _$BreedResponseFromJson(json);
}

@freezed
class PageLinkResponse with _$PageLinkResponse {
  const factory PageLinkResponse({
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'active') required bool active,
  }) = _PageLinkResponse;

  factory PageLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$PageLinkResponseFromJson(json);
}
