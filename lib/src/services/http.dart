import "package:mta/data.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class HttpException implements Exception {
  final int statusCode;
  final String message;

  const HttpException(this.statusCode, this.message);

  @override
  String toString() => message;
}

extension HttpResponseUtils on http.Response {
  void throwHttpError(String context) {
    if (statusCode != 200) {
      throw HttpException(statusCode, "$context: $body");
    }
  }

  List<Json> toJsonList() {
    final data = jsonDecode(body) as List;
    return data.cast<Json>();
  }
}
