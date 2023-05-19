import 'package:dumaem_messenger/properties/config.dart';
import 'package:flutter/material.dart';

import '../models/setting.dart';
import '../widgets/avatar_card.dart';
import '../widgets/setting_tile.dart';
import '../widgets/support_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, '/home');
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/home');
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AvatarCard(),
                  const SizedBox(height: secondSizedBoxHeight),
                  const Divider(),
                  const SizedBox(height: thirdSizedBoxHeight),
                  Column(
                    children: List.generate(
                      settings.length,
                      (index) => SettingTile(setting: settings[index]),
                    ),
                  ),
                  const SizedBox(height: thirdSizedBoxHeight),
                  const Divider(),
                  const SizedBox(height: thirdSizedBoxHeight),
                  Column(
                    children: List.generate(
                      settings2.length,
                      (index) => SettingTile(setting: settings2[index]),
                    ),
                  ),
                  const SizedBox(height: secondSizedBoxHeight),
                  const SupportCard()
                ],
              ),
            ),
          ),
        ));
  }
}
