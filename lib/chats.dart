import 'package:dumaem_messenger/properties/config.dart';
import 'package:flutter/material.dart';

import 'components/drawer.dart';
import 'localization/generated/l10n.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool isDefaultAppBar = true;
  String searchText = "";
  TextEditingController searchController = TextEditingController();

  AppBar getDefaultAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              searchController.clear();
              searchText = "";
              isDefaultAppBar = !isDefaultAppBar;
            });
          },
          icon: const Icon(Icons.close),
        )
      ],
      title: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
          });
        },
        decoration: const InputDecoration(label: Text('Название')),
      ),
    );
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).app_bar_title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isDefaultAppBar = !isDefaultAppBar;
            });
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isDefaultAppBar
          ? getSearchAppBar(context)
          : getDefaultAppBar(context),
      drawer: const MenuDrawer(),
      body: ListView(
        children: chatsList.map(
          (deal) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(baseBorderRadius),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(baseBorderRadius),
                ),
                leading: CircleAvatar(
                  child: Text(deal.title![0].toUpperCase()),
                ),
                trailing: CircleAvatar(
                  maxRadius: chatCircleAvatarRadius,
                  child: Text(deal.countOfUnreadMessages.toString(),
                      style: const TextStyle(fontSize: chatTextFontSize)),
                ),
                title: Text(deal.title!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(deal.lastMessage!),
                onTap: () {},
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class Chat {
  int? id;
  String? title;
  String? lastMessage;
  int? countOfUnreadMessages;
  Chat({this.id, this.title, this.lastMessage, this.countOfUnreadMessages});
}

List<Chat> chatsList = [
  Chat(
      id: 1,
      title: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 2,
      title: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 3,
      title: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 4,
      title: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
  Chat(
      id: 1,
      title: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 2,
      title: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 3,
      title: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 4,
      title: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
  Chat(
      id: 1,
      title: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 2,
      title: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 3,
      title: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 4,
      title: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
];
