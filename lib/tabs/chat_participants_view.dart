import 'package:flutter/material.dart';

import '../properties/chat_page_arguments.dart';
import '../properties/config.dart';

class ChatParticipantsView extends StatelessWidget {
  const ChatParticipantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: chatsList.map(
          (chat) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(baseBorderRadius),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(baseBorderRadius),
                ),
                leading: CircleAvatar(
                  child: Text(chat.name![0].toUpperCase()),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_circle_outlined),
                ),
                title: Text(chat.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                // onTap: () {
                //   Navigator.pushNamed(context, '/chat',
                //       arguments: ScreenArguments(chat.id));
                // },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

// test data
class Chat {
  int id;
  String? name;
  String? lastMessage;
  int? countOfUnreadMessages;

  Chat(
      {required this.id,
      this.name,
      this.lastMessage,
      this.countOfUnreadMessages});
}

List<Chat> chatsList = [
  Chat(
      id: 1,
      name: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 2,
      name: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 3,
      name: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 4,
      name: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
  Chat(
      id: 5,
      name: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 6,
      name: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 7,
      name: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 8,
      name: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
  Chat(
      id: 9,
      name: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 10,
      name: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 11,
      name: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 12,
      name: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
  Chat(
      id: 9,
      name: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 10,
      name: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 11,
      name: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 12,
      name: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
];
