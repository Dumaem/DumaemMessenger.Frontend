import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../properties/config.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.support_agent,
            size: 50,
          ),
          const SizedBox(width: 10),
          Text(
            S.of(context).settings_support_title,
            style: const TextStyle(
              fontSize: ksmallFontSize,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}