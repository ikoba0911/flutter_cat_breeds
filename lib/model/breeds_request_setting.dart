import 'dart:convert';

import 'package:flutter_cat_breeds/domain/breed.dart';
import 'package:flutter_cat_breeds/model/breeds_response.dart';
import 'package:flutter_cat_breeds/util/http_request_setting.dart';

final class BreedsRequestSetting implements HttpRequestSetting<List<Breed>> {
  BreedsRequestSetting({this.limit = 10, this.page});

  final int limit;
  final int? page;

  @override
  List<Breed> decode(dynamic data) {
    final map = json.decode(data) as Map<String, dynamic>;
    final response = BreedsResponse.fromJson(map);

    final list = response.data
        .map(
          (e) => Breed(
            breed: e.breed,
            country: e.country,
            origin: e.origin,
            coat: e.coat,
            pattern: e.pattern,
          ),
        )
        .toList();

    return list;
  }

  @override
  HttpRequestEndpoint get endpoint => HttpRequestEndpoint(
        host: 'https://catfact.ninja',
        path: '/breeds',
      );

  @override
  Future<Map<String, String>> headers() => Future(
        () => {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

  @override
  HttpRequestMethod get method => HttpRequestMethod.get;

  @override
  Future<Map<String, dynamic>> parameters() async {
    final params = <String, dynamic>{
      'limit': limit,
    };
    if (page != null) {
      params['page'] = page;
    }
    return params;
  }
}
