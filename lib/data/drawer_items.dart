import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/drawer_item.dart';

class DrawerItems {
  static const home = DrawerItem(title: 'Home', icon: FontAwesomeIcons.home);
  static const settings = DrawerItem(title: 'Settings', icon: Icons.settings);

  static final List<DrawerItem> all = [
    home,
    settings,
  ];
}