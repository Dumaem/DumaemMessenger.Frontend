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
    // final accessToken = await storage.read(key: 'accessToken');
    final accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ3aW5naW1vYmlsZUBnbWFpbC5jb20iLCJqdGkiOiI0N2ZiYTJkZi1kZTBmLTQ5Y2UtODZlZS01NDNhYmRkMWQ0YzEiLCJlbWFpbCI6IndpbmdpbW9iaWxlQGdtYWlsLmNvbSIsImlkIjoiMSIsImRldmljZUlkIjoiP2hDYz8_XHUwMDAyMD9rXHUwMDFlNz89P1I7XHUwMDA2fzU_Mz92Pz8oXHIwPz9uIiwibmJmIjoxNjg0MDQ3MDAyLCJleHAiOjE2ODQwNDc2MTIsImlhdCI6MTY4NDA0NzAwMn0.yo5pMW4JPGewSOhZ9Pt7sn9FX6WCa1oY7q4EsU7Qd5Q";
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  // // You can also perform some actions in the response or onError.
  // @override
  // Future<void> onResponse(
  //     Response response, ResponseInterceptorHandler handler) async {
  //   if (response.statusCode == 401) {
  //     final newAccessToken = await refreshToken();
  //     if (newAccessToken != null) {
  //       response.requestOptions.headers['Authorization'] =
  //           'Bearer $accessTokenKey';
  //       DioHttpClient.dio.request(response.requestOptions.path,
  //           options: Options(
  //               method: response.requestOptions.method,
  //               headers: response.requestOptions.headers,
  //               extra: response.extra));
  //     }
  //   }
  //   return handler.next(response);
  // }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Access token expired, refresh it
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

    // Create a new Dio instance for the token refresh request

    final response = await DioHttpClient.dio.post(
      'Authorization/refresh',
      data: {
        'token': {accessTokenKey: accessToken, refreshTokenKey: refreshToken}
      },
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['token'][accessTokenKey];
      final newRefreshToken = response.data['token'][refreshTokenKey];

      // Update the stored access token
      await storage.write(key: accessTokenKey, value: newAccessToken);
      await storage.write(key: refreshTokenKey, value: newRefreshToken);

      return newAccessToken;
    }
  } catch (error) {
    throw Exception("Tokens can not be updated");
  }
}
