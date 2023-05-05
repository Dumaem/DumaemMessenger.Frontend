import 'package:dio/dio.dart';

class HttpClient {
  static late Dio dio;

  static BaseOptions options =
      BaseOptions(baseUrl: 'https://localhost:7213/api/');

  static void initializeStaticDio() {
    dio = Dio(options);
  }
}
