class Request {
  final String method;
  final String path;
  final Uri uri;
  final DateTime date;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;

  const Request({
    required this.method,
    required this.path,
    required this.uri,
    required this.date,
    this.headers,
    this.body,
    this.queryParameters,
  });
}
