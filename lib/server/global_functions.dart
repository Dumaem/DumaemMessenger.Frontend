import 'package:dumaem_messenger/server/signalr_connection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'global_variables.dart';

class GlobalFunctions {
  static Future<dynamic> writeUserInfo(dynamic response) async {
    print('writing user info with token gotten');
    final newAccessToken = response.data[accessTokenKey];
    final newRefreshToken = response.data[refreshTokenKey];
    final userId = response.data[userKey];

    await storage.write(key: accessTokenKey, value: newAccessToken);
    await storage.write(key: refreshTokenKey, value: newRefreshToken);
    await storage.write(key: userKey, value: "$userId");
    await storage.read(key: userKey);

    return newAccessToken;
  }

  static Future logout() async {
    print('logout invoked');
    logoutRequested = true;
    await SignalRConnection.hubConnection.stop();
    await storage.deleteAll();
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/authorization', (Route<dynamic> route) => false);
  }

  static String formatISOTime(DateTime date) {
    return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}Z");
  }
}
