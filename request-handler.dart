import 'dart:convert';
import 'dart:io';

import 'commons.dart';

class RequestHandler {
  handleGET(HttpRequest request) {
    final query = request.uri.queryParameters;
    String responseString = "Hi! I am Ye Htet Hein";
    responseBack(request, HttpStatus.ok, responseString);
  }

  Future handlePOST(HttpRequest request) async{
    if (request.headers.contentType?.mimeType == "application/json") {
      try {
        String content = await utf8.decoder.bind(request).join();
        Map data = jsonDecode(content) as Map;
        String fname = request.uri.pathSegments.length > 0 ? request.uri.pathSegments.last : "result.txt";
        await File(fname).writeAsString(content);
        responseBack(request, HttpStatus.ok, data);
      } catch (e) {
        responseError(request, HttpStatus.internalServerError,
          "Internal Server Error!");
      }
    } else {
      responseError(request, HttpStatus.forbidden,
          "Sorry! we only allow json request. Please check your requested headers.");
    }

  }

  handlePUT(HttpRequest request) {}

  handleDELETE(HttpRequest request) {}
}
