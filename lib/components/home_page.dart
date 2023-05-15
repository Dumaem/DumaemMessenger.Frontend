import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../class_builder.dart';
import '../generated/l10n.dart';
import '../pages/chats_page.dart';
import '../properties/config.dart';
import '../server/global_variables.dart';
import '../server/signalr_connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('ChatsPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: const Text('Chats',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          icon: const Icon(Icons.chat, color: Colors.black),
          page: ChatsPage(),
        ),
        KFDrawerItem(
          text: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          icon: const Icon(Icons.settings, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        borderRadius: 20,
        shadowBorderRadius: 20.0,
        controller: _drawerController,
        footer: KFDrawerItem(
          text: const Text(
            'Logout',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () async {
            await SignalRConnection.hubConnection.stop();
            await storage.deleteAll();
            Navigator.popAndPushNamed(context, '/authorization');
          },
        ),
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
                title: Row(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: secondaryCircleAvatarRadius,
                      child: Text("R"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(S.of(context).account_name_test,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black)),
                        const SizedBox(height: 2),
                        Text(S.of(context).account_email_test,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(234, 253, 252, 255),
              Color.fromARGB(234, 253, 252, 255)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
