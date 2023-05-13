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
    final accessToken = await storage.read(key: 'access_token');
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
    final refreshToken = await storage.read(key: refreshTokenKey);

    // Create a new Dio instance for the token refresh request

    final response = await DioHttpClient.dio.post(
      'Authorization/refresh',
      data: {'refresh_token': refreshToken},
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['token']['accessToken'];

      // Update the stored access token
      await storage.write(key: accessTokenKey, value: newAccessToken);

      return newAccessToken;
    }
  } catch (error) {
    // Handle token refresh request failure
  }
}
