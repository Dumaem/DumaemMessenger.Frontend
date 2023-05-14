import 'package:dumaem_messenger/properties/chat_page_arguments.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'generated/l10n.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool isDefaultAppBar = true;
  String searchText = "";
  //final List<Chat> chats;
  TextEditingController searchController = TextEditingController();
  List<Chat> filterChats = chatsList;

  Future<void> getChatsList() async
  {
    try{
      var response = await DioHttpClient.dio
                    .get('Chat/get-user-chats-by-id', queryParameters: {"id":storage.read(key: "id")}); 
      if(response.statusCode == 200)
      {
        
      }
    }
    catch(exception){
      print('lol');
    }
  } 

  @override
  Widget build(BuildContext context) {
    getChatsList();
    return Scaffold(
      appBar: isDefaultAppBar
          ? getSearchAppBar(context)
          : getDefaultAppBar(context),
      body: ListView(
        children: filterChats.map(
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
                  child: Text(chat.title![0].toUpperCase()),
                ),
                trailing: CircleAvatar(
                  maxRadius: chatCircleAvatarRadius,
                  child: Text(chat.countOfUnreadMessages.toString(),
                      style: const TextStyle(fontSize: chatTextFontSize)),
                ),
                title: Text(chat.title!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  children: [
                    Text(chat.senderName == null ? "null: " : "${chat.senderName!}: "),
                    Text(chat.lastMessage!)
                ]),
                onTap: () {
                  Navigator.pushNamed(context, '/chat',
                      arguments: ScreenArguments(chat.id));
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }

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
            filterChats = chatsList
                .where((element) =>
                    element.title!.toLowerCase().contains(searchText))
                .toList();
          });
        },
        decoration: InputDecoration(label: Text(S.of(context).chat_name_title)),
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
}

class Chat {
  int id;
  String? title;
  String? lastMessage;
  String? senderName;
  int? countOfUnreadMessages;
  Chat(
      {required this.id,
      this.title,
      this.lastMessage,
      this.countOfUnreadMessages, 
      this.senderName});
}

List<Chat> chatsList = [
  Chat(
      id: 1,
      title: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10,
      senderName: "You"),
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
      id: 5,
      title: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 6,
      title: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 7,
      title: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 8,
      title: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
  Chat(
      id: 9,
      title: 'Фермеры',
      lastMessage: 'Купить молоко,хлеб,сыр',
      countOfUnreadMessages: 10),
  Chat(
      id: 10,
      title: 'КТИТС',
      lastMessage: 'Прописать Flutter upgrade',
      countOfUnreadMessages: 87),
  Chat(
      id: 11,
      title: 'думаем',
      lastMessage: 'Выиграть в турнире',
      countOfUnreadMessages: 4),
  Chat(
      id: 12,
      title: "Избранное",
      lastMessage: "Сходить за посылкой на почту",
      countOfUnreadMessages: 1),
];
