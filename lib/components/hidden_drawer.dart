import 'package:dumaem_messenger/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../pages/chats.dart';
import '../localization/generated/l10n.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Dumaem Messenger",
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        ChatsPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Settings',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        SettingsPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Shop',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        ChatsPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Info',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        ChatsPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color.fromARGB(255, 130, 170, 227),
      screens: _pages,
      initPositionSelected: 0,

    );
  }
}