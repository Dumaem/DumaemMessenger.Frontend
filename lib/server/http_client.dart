import 'package:dio/dio.dart';

class HttpClient {
  static late Dio dio;

  static BaseOptions options = BaseOptions(baseUrl: 'затычка');

  static void initializeStaticDio() {
    dio = Dio(options);
  }
}
