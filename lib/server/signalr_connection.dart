import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRConnection {
  static late HubConnection hubConnection;
  static late Logger hubProtLogger;
  static late Logger transportProtLogger;
  static late HttpConnectionOptions httpOptions;

  static const serverUrl = "192.168.10.50:51001";

  static void intitalizeSignalRConnection() {
    httpOptions = HttpConnectionOptions(logger: transportProtLogger);

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    hubProtLogger = Logger("SignalR - hub");
    transportProtLogger = Logger("SignalR - transport");

    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .configureLogging(hubProtLogger)
        .build();

    hubConnection.onclose((error) => print("Connection Closed"));

    startSignalR();
  }

  static void startSignalR() async {
    await hubConnection.start();
  }
}
