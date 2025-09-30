import 'dart:convert';
import 'package:http/http.dart' as http;

enum HttpSessionMethod { get, post, patch, put, delete }

final class HttpSessionResponse {
  final int code;
  final Map<String, String> headers;
  final String body;
  HttpSessionResponse(
      {required this.code, required this.headers, required this.body});

  @override
  String toString() {
    return 'HttpSessionResponse\n  code: $code,\n  headers: $headers,\n  body: $body';
  }
}

final class HttpSessionSetting {
  const HttpSessionSetting();
  static const defaultSession = HttpSessionSetting();

  Future<HttpSessionResponse> request({
    required Uri url,
    required HttpSessionMethod method,
    required Map<String, String> headers,
    required Map<String, dynamic> parameters,
  }) async {
    Uri urlWithQueries() {
      final queries = _encode(parameters: parameters);
      return Uri.parse('${url.toString()}?$queries');
    }

    Future<http.Response> invoke() async {
      switch (method) {
        case HttpSessionMethod.get:
          return await http.get(
            urlWithQueries(),
            headers: headers,
          );
        case HttpSessionMethod.delete:
          return await http.delete(
            urlWithQueries(),
            headers: headers,
          );
        case HttpSessionMethod.post:
          return await http.post(
            url,
            headers: headers,
            body: json.encode(parameters),
          );
        case HttpSessionMethod.put:
          return await http.put(
            url,
            headers: headers,
            body: json.encode(parameters),
          );
        case HttpSessionMethod.patch:
          return await http.patch(
            url,
            headers: headers,
            body: json.encode(parameters),
          );
      }
    }

    final response = await invoke();
    return HttpSessionResponse(
        code: response.statusCode,
        headers: response.headers,
        body: response.body);
  }

  String _encode({required Map<String, dynamic> parameters}) {
    return parameters.entries.map((element) {
      if (element.value is List) {
        final value = element.value as List;
        return value
            .map((listValue) =>
                '${element.key}[]=${Uri.encodeComponent(listValue.toString())}')
            .join('&');
      } else {
        return '${element.key}=${Uri.encodeComponent(element.value.toString())}';
      }
    }).join('&');
  }
}
