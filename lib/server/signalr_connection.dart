import 'package:dumaem_messenger/server/auth_interceptor.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:signalr_core/signalr_core.dart';

class CustomClient extends http.BaseClient {
  final http.BaseClient client = http.Client() as http.BaseClient;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final accessToken = await storage.read(key: accessTokenKey);

    request.headers['Authorization'] = 'Bearer $accessToken';
    return client.send(request);
  }
}

class SignalRConnection {
  static late HubConnection hubConnection;
  static late Logger hubProtLogger;
  static late Logger transportProtLogger;

  static const serverUrl = "https://217.66.25.183:7213/z";

  static void intitalizeSignalRConnection() async {
    hubProtLogger = Logger("SignalR - hub");
    transportProtLogger = Logger("SignalR - transport");
    var options = HttpConnectionOptions(
      client: CustomClient(),
      logging: (level, message) => print(message),
    );

    hubConnection = HubConnectionBuilder().withUrl(serverUrl, options).build();

    hubConnection.onclose((Exception? error) => print("Connection Closed"));

    hubConnection.on('ReceiveMessage', (message) {
      print('123');
    });

    hubConnection.on('Unauthorized', (arguments) async {
      print('Unauthorized error');
      await refreshToken();
      await startSignalR();
    });

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    try {
      await hubConnection.start();
    } catch (error) {
      await refreshToken();
    }
  }

  static Future<void> startSignalR() async {
    await hubConnection.start();
  }

  static String formatISOTime(DateTime date) {
    return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}Z");
  }
}
