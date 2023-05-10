import 'package:dumaem_messenger/pages/settings.dart';
import 'package:dumaem_messenger/pages/chats.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../class_builder.dart';
import '../home.dart';
import '../pages/chats.dart';
import '../generated/l10n.dart';
import '../properties/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Home'),
      items: [
        KFDrawerItem.initWithPage(
          text: const Text('Home',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.home, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text('Profile',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.account_box, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text('Notifications',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.notifications_active, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text('Stats',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.trending_up, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text('Schedules',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.av_timer, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text('Settings',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.settings, color: Colors.white),
          page: Home(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.8,
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Riaz Zaripof',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                    SizedBox(height: 2),
                    Text('Developer',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: KFDrawerItem(
            text: Text(S.of(context).sign_up_title,
                style: const TextStyle(fontSize: 18, color: Colors.white))),
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 130, 170, 227)),
      ),
    );
  }
}
