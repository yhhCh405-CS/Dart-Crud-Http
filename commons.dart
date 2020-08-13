import 'dart:io';

responseError(HttpRequest request, int status, String message) {
  request.response
    ..statusCode = status
    ..write("${status} "+message)
    ..close();
}

responseBack(HttpRequest request, int status, Object obj) {
  request.response
    ..statusCode = status
    ..write(obj)
    ..close();
}