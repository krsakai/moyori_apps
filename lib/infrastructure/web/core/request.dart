abstract class WebRequest {
  const WebRequest();
  String get path;
  HttpMethod get httpMethod;
  Map<String, String> get httpHeaders;
  dynamic get data;
  Map<String, dynamic> get queryParameters;
}

enum HttpMethod {
  get,
  post,
}

extension HttpMethodExtension on HttpMethod {
  String get value {
    switch (this) {
      case HttpMethod.post:
        return 'POST';
      default:
        return 'GET';
    }
  }
}

/// API-KEYを判別するための識別子。
enum APIType {
  sample
}
