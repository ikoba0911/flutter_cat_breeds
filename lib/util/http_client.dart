import 'package:flutter_cat_breeds/util/http_request_setting.dart';
import 'package:flutter_cat_breeds/util/http_session_setting.dart';

abstract interface class HttpClientErrorHandlerInterface {
  void handle({required Exception error});
}

final class HttpClientExceptionUndefined implements Exception {}

final class HttpClientExceptionDecodeFormat implements FormatException {
  @override
  final String source;
  @override
  final String message;
  @override
  final int? offset;

  HttpClientExceptionDecodeFormat(
      {required this.source, required this.message, required this.offset});
}

final class HttpClientExceptionTypeError implements Exception {
  final String message;
  final StackTrace? stackTrace;

  HttpClientExceptionTypeError(
      {required this.message, required this.stackTrace});
}

// status code 400
final class HttpClientExceptionClientError implements Exception {
  final int httpStatusCode;
  HttpClientExceptionClientError({required this.httpStatusCode});
}

// status code 500
final class HttpClientExceptionServerError implements Exception {
  final int httpStatusCode;
  HttpClientExceptionServerError({required this.httpStatusCode});
}

final class HttpClient {
  static late HttpClientErrorHandlerInterface _errorHandler;

  final HttpSessionSetting _session;

  static void setupErrorHandler(
      {required HttpClientErrorHandlerInterface handler}) {
    _errorHandler = handler;
  }

  HttpClient({HttpSessionSetting session = HttpSessionSetting.defaultSession})
      : _session = session;

  Future<T> request<T>({required HttpRequestSetting<T> setting}) async {
    final headers = await setting.headers();
    final parameters = await setting.parameters();
    final response = await _session.request(
        url: setting.endpoint.url,
        method: setting.method.toHttpSessionValue,
        headers: headers,
        parameters: parameters);

    if (response.code >= 200 && response.code < 300) {
      try {
        return setting.decode(response.body);
      } catch (error) {
        if (error is FormatException) {
          throw HttpClientExceptionDecodeFormat(
              source: error.source,
              message: error.message,
              offset: error.offset);
        } else if (error is TypeError) {
          throw HttpClientExceptionTypeError(
            message: error.toString(),
            stackTrace: error.stackTrace,
          );
        } else {
          throw HttpClientExceptionUndefined();
        }
      }
    }

    Exception makeError({required HttpSessionResponse response}) {
      if (response.code >= 300 && response.code < 400) {
        return HttpClientExceptionUndefined();
      } else if (response.code >= 400 && response.code < 500) {
        try {
          return HttpClientExceptionClientError(
            httpStatusCode: response.code,
          );
        } catch (error) {
          return HttpClientExceptionClientError(
            httpStatusCode: response.code,
          );
        }
      } else if (response.code >= 500) {
        return HttpClientExceptionServerError(httpStatusCode: response.code);
      } else {
        return HttpClientExceptionUndefined();
      }
    }

    final error = makeError(response: response);
    _errorHandler.handle(error: error);
    throw error;
  }
}

extension _HttpRequestMethodExt on HttpRequestMethod {
  HttpSessionMethod get toHttpSessionValue {
    switch (this) {
      case HttpRequestMethod.get:
        return HttpSessionMethod.get;
      case HttpRequestMethod.post:
        return HttpSessionMethod.post;
      case HttpRequestMethod.patch:
        return HttpSessionMethod.patch;
      case HttpRequestMethod.put:
        return HttpSessionMethod.put;
      case HttpRequestMethod.delete:
        return HttpSessionMethod.delete;
    }
  }
}
