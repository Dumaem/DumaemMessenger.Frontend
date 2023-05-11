import 'dart:convert';
import 'dart:io';

import 'package:dumaem_messenger/models/message_context.dart';
import 'package:dumaem_messenger/server/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:signalr_core/signalr_core.dart';

class CustomClient extends http.BaseClient {
  final http.BaseClient client = http.Client() as http.BaseClient;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWVuaXJ1QG1haWwucnUiLCJqdGkiOiJlOWI1YmRlZi1kM2ZlLTRmODYtYWE0Mi00ZTk1ZDUwZDhkODEiLCJlbWFpbCI6ImFtZW5pcnVAbWFpbC5ydSIsImlkIjoiMTMiLCJkZXZpY2VJZCI6Ij9oQ2M_P1x1MDAwMjA_a1x1MDAxZTc_PT9SO1x1MDAwNn81PzM_dj8_KFxyMD8_biIsIm5iZiI6MTY4MzgwNjEzNSwiZXhwIjoxNjgzODA2NzQ1LCJpYXQiOjE2ODM4MDYxMzV9.hD6K_4nvM93gnm882yhVbd0iFAL5HdjVRG1L7vbyIek';
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

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    startSignalR();
  }

  static Future<void> startSignalR() async {
    await hubConnection.start();
    await hubConnection.send(methodName: 'SendMessageToChat', args: <Object>[
      {
        'ContentType': 1,
        'ChatId': 'testChat1',
        'Content': '123',
        'ForwardedMessageId': null,
        'RepliedMessageId': null,
        'UserId': 0,
        'SendDate': DateTime.now().toUtc()
      }
    ]);

    var data = DateTime.now().toUtc().toString();
  }

  static Future<String> getAccessToken() async {
    //FlutterSecureStorage _storage = const FlutterSecureStorage();
    return ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWVuaXJ1QG1haWwucnUiLCJqdGkiOiI3Nzg1ZDI1Zi1mMTk5LTRhMzEtYjRmMC1jMGZiNTI5NmYyM2MiLCJlbWFpbCI6ImFtZW5pcnVAbWFpbC5ydSIsImlkIjoiMiIsImRldmljZUlkIjoiPz80VD8_Pz8uPz9BXHUwMDEwXHUwMDA0XT8_XHUwMDE3YT9cdTAwMTI_QyQ_Pz8_TG1cdTAwMDc0IiwibmJmIjoxNjgzNzQxODQ1LCJleHAiOjE2ODM3NDI3NDUsImlhdCI6MTY4Mzc0MTg0NX0.ceixlGNwwsVzZPBvSXeId-neS2J2N3hDAleBR9bp5cQ");
  }
}
