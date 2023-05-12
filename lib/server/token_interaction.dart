import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'http_client.dart';

class TokenInteraction {
  static late FlutterSecureStorage storage;

  static void initializeStorage() {
    storage = const FlutterSecureStorage();
  }

  static void setTokensToStorage(String accessToken, String refreshToken) {
    storage.write(key: 'accessToken', value: accessToken);
    storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String?> getAccessTokenFromStorage() {
    return storage.read(key: 'accessToken');
  }

  static Future<String?> getRefreshTokenFromStorage() {
    return storage.read(key: 'refreshToken');
  }

  static Future<String> getAccessTokenFromServer() async {
    var response =
        await DioHttpClient.dio.post('Authorization/login', data: {});
    return "1";
  }
}
