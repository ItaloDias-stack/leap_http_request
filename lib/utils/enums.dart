enum HttpMethods {
  get('GET'),

  post('POST'),

  put('PUT'),

  patch('PATCH'),

  delete('DELETE');

  const HttpMethods(this.method);

  final String method;
}
