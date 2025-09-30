final class HttpRequestEndpoint {
  final String host;
  final String path;

  Uri get url => Uri.parse('$host$path');

  HttpRequestEndpoint({required this.host, required this.path});
}

enum HttpRequestMethod { get, post, patch, put, delete }

abstract interface class HttpRequestSetting<T> {
  HttpRequestEndpoint get endpoint;
  HttpRequestMethod get method;
  Future<Map<String, dynamic>> parameters();
  Future<Map<String, String>> headers();
  T decode(dynamic data); // response
}
