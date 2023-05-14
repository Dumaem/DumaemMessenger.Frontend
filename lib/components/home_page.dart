import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../class_builder.dart';
import '../pages/chats_page.dart';

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
        KFDrawerItem.initWithPage(
          text: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          icon: const Icon(Icons.account_box, color: Colors.black),
          page: ChatsPage(),
        ),
        KFDrawerItem(
          text: const Text(
            'Notifications',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          icon: const Icon(Icons.notifications_active, color: Colors.black),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/chatInfo');
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
        scrollable: true,
        controller: _drawerController,
        footer: KFDrawerItem(
          text: const Text(
            'Logout',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () {
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
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                            image: NetworkImage(
                                // временная затычка.
                                "https://sun9-48.userapi.com/impg/3Tr7i0Yi7Edt6tKh2_sgVacRsDu42XGst7phpw/qIdXkvVR5vE.jpg?size=1536x2048&quality=95&sign=b3c6d31138f00b7cde0e1898d5303f3c&type=album"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Riaz Zaripof',
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                      SizedBox(height: 2),
                      Text('Developer',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                ],
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
