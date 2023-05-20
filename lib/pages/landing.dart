import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:flutter/material.dart';

import '../server/signalr_connection.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<void> loading() async {
    var result = await SignalRConnection.intitalizeSignalRConnection();
    if(result)
    {
      navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: loading(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                alignment: Alignment.center,
                child: Image.asset('lib/images/DumaemLogo.png'),
              );
            }));
  }
}
