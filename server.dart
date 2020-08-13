import 'dart:io';

import 'commons.dart';
import 'methods-annon.dart';
import 'request-handler.dart';

Future main(List<String> args) async {
  InternetAddress address = InternetAddress.loopbackIPv4;
  int port = 3000;
  var server = await HttpServer.bind(address, port);
  print("Listening on host ${address.address} and port $port ...");
  await for (HttpRequest request in server) {
    handleRequest(request);
  }
}

handleRequest(HttpRequest request) {
  String method = request.method;
  try {
    switch (method) {
      case HttpRequestMethods.GET:
        RequestHandler().handleGET(request);
        break;
      case HttpRequestMethods.POST:
        RequestHandler().handlePOST(request);
        break;
      case HttpRequestMethods.PUT:
        RequestHandler().handlePUT(request);
        break;
      case HttpRequestMethods.DELETE:
        RequestHandler().handleDELETE(request);
        break;
      default:
      responseError(request, HttpStatus.methodNotAllowed, "Unsupported Request!");
    }
  } catch (e) {
    responseError(request, HttpStatus.internalServerError, "Exception in request handling: $e");
  }
}


