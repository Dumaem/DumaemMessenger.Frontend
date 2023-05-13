import 'package:dumaem_messenger/server/auth_interceptor.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
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

  static const serverUrl = "https://10.0.2.2:7213/z";

  static void intitalizeSignalRConnection() {
    hubProtLogger = Logger("SignalR - hub");
    transportProtLogger = Logger("SignalR - transport");
    var options = HttpConnectionOptions(
      client: CustomClient(),
      logging: (level, message) => print(message),
    );

    hubConnection = HubConnectionBuilder().withUrl(serverUrl, options).build();

    hubConnection.onclose((Exception? error) => print("Connection Closed"));

    hubConnection.on('Test', (argument) {
      print('test worked');
    });

    hubConnection.on('ReceiveMessage', (message) {
      print('123');
    });

    hubConnection.on('Unauthorized', (arguments) async {
      print('Unauthorized error');
      await refreshToken();
    });

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    startSignalR();
  }

  static Future<void> startSignalR() async {
    await hubConnection.start();
    // await hubConnection.send(methodName: 'SendMessageToChat', args: <Object>[
    //   {
    //     'ContentType': 1,
    //     'ChatId': 'testChat1',
    //     'Content': '123',
    //     'ForwardedMessageId': null,
    //     'RepliedMessageId': null,
    //     'UserId': 0,
    //     'SendDate': formatISOTime(DateTime.now())
    //   }
    // ]);
  }

  static Future<String> getAccessToken() async {
    //FlutterSecureStorage _storage = const FlutterSecureStorage();
    return ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWVuaXJ1QG1haWwucnUiLCJqdGkiOiI3Nzg1ZDI1Zi1mMTk5LTRhMzEtYjRmMC1jMGZiNTI5NmYyM2MiLCJlbWFpbCI6ImFtZW5pcnVAbWFpbC5ydSIsImlkIjoiMiIsImRldmljZUlkIjoiPz80VD8_Pz8uPz9BXHUwMDEwXHUwMDA0XT8_XHUwMDE3YT9cdTAwMTI_QyQ_Pz8_TG1cdTAwMDc0IiwibmJmIjoxNjgzNzQxODQ1LCJleHAiOjE2ODM3NDI3NDUsImlhdCI6MTY4Mzc0MTg0NX0.ceixlGNwwsVzZPBvSXeId-neS2J2N3hDAleBR9bp5cQ");
  }

  static String formatISOTime(DateTime date) {
    return ("${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}Z");
  }
}
