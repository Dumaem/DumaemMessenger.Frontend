import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../generated/l10n.dart';
import '../models/user_model.dart';
import '../properties/config.dart';
import '../server/user/user_service.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({super.key});

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  final UserService _userService = UserService();
  late Future<UserModel> _getCurrentUser;

  @override
  void initState() {
    _getCurrentUser = _userService.getUserView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _getCurrentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(alignment: Alignment.center, child: LoadingAnimationWidget.twoRotatingArc(
                  color: Colors.white,
                  size: 50,
                ),);
        } else {
          return Row(
            children: [
              CircleAvatar(
                radius: primaryCircleAvatarRadius,
                child: Text(snapshot.data?.name[0].toUpperCase() as String),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    snapshot.data?.name as String,
                    style: const TextStyle(
                      fontSize: kbigFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    snapshot.data?.email as String,
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
      },
    );
  }
}
