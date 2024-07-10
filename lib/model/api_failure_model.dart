class ApiFailure {
  final int code;
  final dynamic response;
  final String? message;
  const ApiFailure({
    required this.code,
    this.message,
    this.response,
  });

  @override
  String toString() {
    return "Status code=> $code, Data => $response";
  }
}
