import 'package:dio/dio.dart';

class HttpClient {
  static late Dio dio;

  static BaseOptions options =
      BaseOptions(baseUrl: 'https://localhost:7213/api/', headers: {
    "Access-Control-Allow-Origin": '*',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Credentials":
        true, // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
  });

  static void initializeStaticDio() {
    dio = Dio(options);
  }
}
