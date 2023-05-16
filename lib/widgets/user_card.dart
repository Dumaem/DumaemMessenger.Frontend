import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              child: Text(user.name[0].toUpperCase()),
            ),
            user.select
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Color.fromARGB(255, 129, 169, 226),
                      child: Icon(
                        color: Colors.black,
                        Icons.check,
                        size: 18,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "@${user.username}",
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
