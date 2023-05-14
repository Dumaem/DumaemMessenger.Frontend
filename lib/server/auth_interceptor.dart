import 'package:dio/dio.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'global_variables.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await storage.read(key: accessTokenKey);
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newAccessToken = await refreshToken();
      if (newAccessToken != null) {
        // Update the access token in the interceptor and retry the original request
        DioHttpClient.dio.options.headers['Authorization'] =
            'Bearer $newAccessToken';
        return DioHttpClient.dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );
      }
    }
    return super.onError(err, handler);
  }
}

Future<String?> refreshToken() async {
  try {
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);

    final response = await DioHttpClient.dio.post(
      'Authorization/refresh',
      data: {
        'token': {accessTokenKey: accessToken, refreshTokenKey: refreshToken}
      },
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['token'][accessTokenKey];
      final newRefreshToken = response.data['token'][refreshTokenKey];

      await storage.write(key: accessTokenKey, value: newAccessToken);
      await storage.write(key: refreshTokenKey, value: newRefreshToken);

      return newAccessToken;
    }
  } catch (error) {
    navigatorKey.currentState?.popAndPushNamed('/authorization');
  }
}
