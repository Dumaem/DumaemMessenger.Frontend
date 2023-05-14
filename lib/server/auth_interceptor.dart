import 'package:dio/dio.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:flutter/widgets.dart';

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
    //final refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWVuaXJ1QG1haWwucnUiLCJqdGkiOiJkMDY4ZjRjZi0xNDhiLTRhNzktYmZlZS0zNWRmZmU1NzBmMWUiLCJlbWFpbCI6ImFtZW5pcnVAbWFpbC5ydSIsImlkIjoiMiIsImRldmljZUlkIjoiP2hDYz8_XHUwMDAyMD9rXHUwMDFlNz89P1I7XHUwMDA2fzU_Mz92Pz8oXHIwPz9uIiwibmJmIjoxNjg0MDA3MzI5LCJleHAiOjE2ODQwMDc5MzksImlhdCI6MTY4NDAwNzMyOX0.InRCyLN92QweM6J6VLyPJzHNm2K2kl5BiLNsvfapJn4";
    final refreshToken = await storage.read(key: refreshTokenKey);
    //final accessToken = "9b5239b7-ed86-403f-9bf8-731f4c863f37";
    final accessToken = await storage.read(key: accessTokenKey);

    final response = await DioHttpClient.dio.post(
      'Authorization/refresh',
      data: {
        'token': {accessTokenKey: accessToken, refreshTokenKey: refreshToken}
      },
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data[accessTokenKey];
      final newRefreshToken = response.data[refreshTokenKey];

      await storage.write(key: accessTokenKey, value: newAccessToken);
      await storage.write(key: refreshTokenKey, value: newRefreshToken);

      return newAccessToken;
    }
  } catch (error) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/authorization', (Route<dynamic> route) => false);
  }
}
