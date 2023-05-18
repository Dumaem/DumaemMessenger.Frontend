import 'package:dumaem_messenger/server/authorization/auth_interceptor.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
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

    print('making a request with signalR http client');
    request.headers['Authorization'] = 'Bearer $accessToken';
    return client.send(request);
  }
}

class SignalRConnection {
  static late HubConnection hubConnection;
  static late Logger hubProtLogger;
  static late Logger transportProtLogger;

  static const serverUrl = "https://217.66.25.183:7213/z";
  // static const serverUrl = "https://10.0.2.2:7152/z";

  static Future<bool> intitalizeSignalRConnection() async {
    hubProtLogger = Logger("SignalR - hub");
    transportProtLogger = Logger("SignalR - transport");
    var options = HttpConnectionOptions(
      client: CustomClient(),
      logging: (level, message) => print(message),
    );

    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options)
        .withAutomaticReconnect()
        .build();

    hubConnection.onclose((Exception? error) async {
      print("Connection Closed");
      if (logoutRequested) {
        logoutRequested = false;
        return;
      }
      try {
        await startSignalR();
        print('hub connection restarted');
      } catch (error) {
        print('refershing after hub connection closed');
        var refresh = await refreshToken();
        if (refresh == null) {
          print('refresh after hubconnection closed resulted a failure');
        }
        await startSignalR();
        print('hub connection restarted');
      }
    });

    hubConnection.on('Unauthorized', (arguments) async {
      print('Unauthorized error');
      savedRequestList.add(arguments);
    });

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    try {
      print('starting signalR connection');
      await hubConnection.start();
      print('signalR connection started');
    } catch (error) {
      print('refreshing token before accession singalR');
      var refresh = await refreshToken();
      if (refresh != null) {
        print('starting hub connection after refreshing');
        await hubConnection.start();
        print('hubconnection started with refresh');
      } else {
        return false;
      }
    }
    return true;
  }

  static Future<void> startSignalR() async {
    print('starting hub connection with startSingalR method');
    await hubConnection.start();
    if (savedRequestList.isEmpty) {
      print('KAKOYTOSTRANNIYDVIZH');
      return;
    }
    var savedRequest = savedRequestList.removeLast();
    hubConnection.send(methodName: savedRequest[0], args: savedRequest[1]);
    print('saved request ${savedRequest[0]} sent');
  }
}
