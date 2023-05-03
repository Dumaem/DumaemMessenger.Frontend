import 'package:dumaem_messenger/properties/config.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final int? id;
  const ChatPage({super.key, required this.id});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
        decoration: const InputDecoration(label: Text('Сообщение')),
      ),
    );
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Dumaem Messenger"),
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
      body: ListView(
        children: messagesList.map(
          (message) {
            return Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(baseBorderRadius),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(baseBorderRadius),
                      ),
                      leading: CircleAvatar(
                        child: Text(message.sender![0].toUpperCase()),
                      ),
                      title: Text(message.sender!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {},
                      subtitle: Text(message.content.toString()),
                    )),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class Message {
  int? id;
  String? sender;
  String? content;
  Message({this.id, this.sender, this.content});
}

List<Message> messagesList = [
  Message(id: 1, sender: 'Фермер', content: 'Привет!'),
  Message(id: 2, sender: 'Копатель', content: 'Привет!'),
  Message(id: 3, sender: 'Космонавт', content: 'Привет!'),
  Message(id: 4, sender: 'Майнер', content: 'Привет!'),
  Message(id: 5, sender: 'Ринат', content: 'Привет!'),
  Message(id: 6, sender: 'Камиль', content: 'Привет!'),
];
