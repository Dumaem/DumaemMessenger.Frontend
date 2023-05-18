import 'package:dio/dio.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:dumaem_messenger/server/global_functions.dart';
import 'package:dumaem_messenger/server/signalr_connection.dart';
import 'package:flutter/widgets.dart';

import '../global_variables.dart';

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

    print('received a ${err.response?.statusCode} error');
    return super.onError(err, handler);
  }
}

Future<String?> refreshToken() async {
  try {
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);

    print('refreshing a token');
    final response = await DioHttpClient.dio.post(
      'Authorization/refresh',
      data: {
        'token': {accessTokenKey: accessToken, refreshTokenKey: refreshToken}
      },
    );
    print('token refresh resulted success');

    if (response.statusCode == 200) {
      var newAccessToken = await GlobalFunctions.writeUserInfo(response);
      return newAccessToken;
    }
  } catch (error) {
    print('token refresh resulted an error: $error');
    GlobalFunctions.logout();
  }
  return null;
}
