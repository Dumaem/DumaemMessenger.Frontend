import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/setting.dart';
import '../properties/config.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, setting.route);
      }, // Navigation
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: klightContentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(setting.icon),
          ),
          const SizedBox(width: 10),
          Text(
            setting.title,
            style: const TextStyle(
              fontSize: ksmallFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}