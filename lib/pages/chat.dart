import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../generated/l10n.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  List<types.Message> _filter_messages = [];
  final _user = const types.User(id: '1');
  bool isDefaultAppBar = true;
  String searchText = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: isDefaultAppBar
            ? getSearchAppBar(context)
            : getDefaultAppBar(context),
        body: Chat(
          messages: _filter_messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          onEndReached: _handleEndReached,
        ),
      );

  Future<void> _handleEndReached() async {
    final messages = data
        .map(
          (e) => types.TextMessage(
            author: _user,
            id: e['_id'] as String,
            text: e['name'] as String,
          ),
        )
        .toList();
    setState(() {
      _messages = [..._messages, ...messages];
      _page = _page + 1;
    });
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
      _filter_messages = _messages;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/home');
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/chatInfo');
        },
        leading: const CircleAvatar(
          child: Text("D"),
        ),
        title: const Text("Название чата"),
      ),
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

  AppBar getDefaultAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              searchController.clear();
              searchText = "";
              isDefaultAppBar = !isDefaultAppBar;
              _filter_messages = _messages;
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
            _filter_messages = _messages
                .where((element) => (element as types.TextMessage)
                    .text
                    .contains(searchText.toLowerCase()))
                .toList();
          });
        },
        decoration:
            InputDecoration(label: Text(S.of(context).message_name_title)),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 2), blurRadius: 7, color: Colors.grey)
                ],
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(color: Color(0xFF00BFA5)),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
