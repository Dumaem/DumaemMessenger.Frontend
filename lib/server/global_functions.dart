import 'package:flutter/material.dart';

import 'global_variables.dart';

class GlobalFunctions
{
  static Future<dynamic> writeUserInfo(dynamic response)
  async {
    final newAccessToken = response.data[accessTokenKey];
    final newRefreshToken = response.data[refreshTokenKey];
    final userId = response.data[userKey];

    await storage.write(key: accessTokenKey, value: newAccessToken);
    await storage.write(key: refreshTokenKey, value: newRefreshToken);
    await storage.write(key: userKey, value: "$userId");
    await storage.read(key: userKey);

    return newAccessToken;
  }
}