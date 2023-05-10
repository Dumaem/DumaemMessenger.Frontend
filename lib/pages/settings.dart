import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../properties/config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
        },
        child: Text(S.of(context).sign_in_title,
            style: const TextStyle(fontSize: fontSizeForHyperText)),
      ),
    );
  }

}