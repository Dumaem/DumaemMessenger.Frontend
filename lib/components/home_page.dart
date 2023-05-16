import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../class_builder.dart';
import '../generated/l10n.dart';
import '../models/user_model.dart';
import '../pages/chats_page.dart';
import '../properties/config.dart';
import '../server/global_variables.dart';
import '../server/signalr_connection.dart';
import '../server/user/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;
  final UserService _userService = UserService();
  late Future<UserModel> _getCurrentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser = _userService.getUserView();

    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('ChatsPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: const Text('Chats',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          icon: const Icon(Icons.chat, color: Colors.black),
          page: ChatsPage(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text('Create chat',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          icon: const Icon(Icons.people_alt_rounded, color: Colors.black),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/createChat');
          },
        ),
        KFDrawerItem(
          text: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          icon: const Icon(Icons.settings, color: Colors.black),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/settings');
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
        header: FutureBuilder<UserModel>(
            future: _getCurrentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25,
                            child: Text(
                                snapshot.data?.name[0].toUpperCase() as String),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snapshot.data?.name as String,
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.black)),
                                  const SizedBox(height: 2),
                                  Text("@${snapshot.data?.username}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
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
