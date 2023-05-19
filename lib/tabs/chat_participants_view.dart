import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/user_model.dart';
import '../properties/chat_page_arguments.dart';
import '../properties/config.dart';
import '../server/user/user_service.dart';

class ChatParticipantsView extends StatefulWidget {
  ChatParticipantsView({Key? key}) : super(key: key);

  @override
  State<ChatParticipantsView> createState() => _ChatParticipantsViewState();
}

class _ChatParticipantsViewState extends State<ChatParticipantsView> {
  List<UserModel> usersList = List.empty(growable: true);

  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    Future<List<UserModel>> _getUsers() async {
      if (usersList.isEmpty) {
        usersList = await _userService.getChatMembers(
            (ModalRoute.of(context)!.settings.arguments as ScreenArguments)
                .chatGuid as String);
      }
      return usersList;
    }

    return FutureBuilder<List<UserModel>>(
      future: _getUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: LoadingAnimationWidget.twoRotatingArc(
              color: Colors.white,
              size: 100,
            ),
          );
        } else {
          if (usersList.isEmpty) {
            usersList = snapshot.data as List<UserModel>;
          }
          return Scaffold(
            body: ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(smallBorderRadius),
                      ),
                      leading: CircleAvatar(
                        child: Text(usersList[index].name![0].toUpperCase()),
                      ),
                      trailing: IconButton(
                        onPressed: RemoveParticipant,
                        icon: const Icon(Icons.remove_circle_outlined),
                      ),
                      title: Text(usersList[index].name!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  void RemoveParticipant() {}
}
