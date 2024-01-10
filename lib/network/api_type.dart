import 'package:dio/dio.dart';

enum APIType { public, protected }

abstract class APIOptions {
  Options options = Options();
}

class PublicApiOptions extends APIOptions {
  PublicApiOptions() {
    super.options.headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
  }
}

class ProtectedApiOptions extends APIOptions {
  ProtectedApiOptions(String apiToken) {
    super.options.headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };
  }
}
