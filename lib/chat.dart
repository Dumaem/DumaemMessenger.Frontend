import 'dart:convert';
import 'dart:math';

import 'package:dumaem_messenger/properties/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

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
  final _user = const types.User(id: '1');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
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
              child: Row(
                children: const [
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
