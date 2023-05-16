import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../properties/config.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: primaryCircleAvatarRadius,
          child: Text("D"),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).account_name_test,
              style: const TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              S.of(context).account_email_test,
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey[600],
              ),
            )
          ],
        )
      ],
    );
  }
}
