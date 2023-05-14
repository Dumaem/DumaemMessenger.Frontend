import 'package:dio/dio.dart';
import 'package:dumaem_messenger/envied/env.dart';
import 'package:dumaem_messenger/server/auth_interceptor.dart';

class DioHttpClient {
  static late Dio dio;

  static BaseOptions options =
      BaseOptions(baseUrl: '${Env.serverUrl}api/', headers: {
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
    addInterceptors();
  }

  static Dio? addInterceptors() {
    dio.interceptors.add(AuthInterceptor());
  }
}
