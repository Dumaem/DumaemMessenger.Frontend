import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/personal_data_page.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    route: "/personalData",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Settings",
    route: "/home",
    icon: Icons.settings,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    route: "/home",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Our Handbook",
    route: "/home",
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  Setting(
    title: "Community",
    route: "/home",
    icon: CupertinoIcons.person_3_fill,
  ),
];