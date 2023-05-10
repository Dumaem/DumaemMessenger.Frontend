import 'package:dumaem_messenger/models/message_context.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRConnection {
  static late HubConnection hubConnection;
  static late Logger hubProtLogger;
  static late Logger transportProtLogger;
  static late HttpConnectionOptions httpOptions;

  static const serverUrl = "https://217.66.25.183:7213/z";

  static void intitalizeSignalRConnection() {
    hubProtLogger = Logger("SignalR - hub");
    transportProtLogger = Logger("SignalR - transport");
    httpOptions = HttpConnectionOptions(logger: transportProtLogger);
    httpOptions.requestTimeout = 50000;
    httpOptions.accessTokenFactory = () async =>
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWVuaXJ1QG1haWwucnUiLCJqdGkiOiJlMzIyZTJhNi1kMjQzLTQ3MmUtYmZkMi1jMzljZDJjOWExNWYiLCJlbWFpbCI6ImFtZW5pcnVAbWFpbC5ydSIsImlkIjoiMTMiLCJkZXZpY2VJZCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTMuMC4wLjAgU2FmYXJpLzUzNy4zNiIsIm5iZiI6MTY4Mzc0MjQ4MiwiZXhwIjoxNjgzNzQyNDkyLCJpYXQiOjE2ODM3NDI0ODJ9.FzXBfznJF9sLrvieiHqxrU3WXgLnBRbGCxtTRiVDnMs";

    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .configureLogging(hubProtLogger)
        .build();

    hubConnection.onclose(({Exception? error}) => print("Connection Closed"));
    hubConnection.on('ReceiveMessage', (message) {
      print((message as MessageContext).Content);
    });

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    startSignalR();
  }

  static Future<void> startSignalR() async {
    await hubConnection.start();
  }

  static Future<String> getAccessToken() async {
    FlutterSecureStorage _storage = const FlutterSecureStorage();
    return ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbWVuaXJ1QG1haWwucnUiLCJqdGkiOiI3Nzg1ZDI1Zi1mMTk5LTRhMzEtYjRmMC1jMGZiNTI5NmYyM2MiLCJlbWFpbCI6ImFtZW5pcnVAbWFpbC5ydSIsImlkIjoiMiIsImRldmljZUlkIjoiPz80VD8_Pz8uPz9BXHUwMDEwXHUwMDA0XT8_XHUwMDE3YT9cdTAwMTI_QyQ_Pz8_TG1cdTAwMDc0IiwibmJmIjoxNjgzNzQxODQ1LCJleHAiOjE2ODM3NDI3NDUsImlhdCI6MTY4Mzc0MTg0NX0.ceixlGNwwsVzZPBvSXeId-neS2J2N3hDAleBR9bp5cQ");
  }
}
