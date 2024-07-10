class HttpResponse {
  int statusCode;
  dynamic data;
  HttpResponse(this.statusCode, this.data);

  @override
  String toString() {
    return 'Status Code=> $statusCode, Response=> $data';
  }
}
