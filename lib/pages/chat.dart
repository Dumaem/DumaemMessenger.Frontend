import 'dart:convert';
import 'dart:math';

import 'package:dumaem_messenger/models/message_context.dart';
import 'package:dumaem_messenger/server/chat/chat_service.dart';
import 'package:dumaem_messenger/server/signalr_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../generated/l10n.dart';
import '../properties/chat_page_arguments.dart';
import '../server/user/user_service.dart';

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
  List<types.Message> _filterMessages = [];
  bool isDefaultAppBar = true;
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  late types.User _currentUser;
  var _chatService = ChatService();
  var _userService = UserService();
  late String _chatName;
  late int _userId;

  @override
  void initState() {
    super.initState();
    SignalRConnection.hubConnection.on("ReceiveMessage", ((message) {
      var res = MessageContext.fromJson(message![0]);

      if (res.ChatId != _chatName) {
        return;
      }
      if (res.UserId == _userId) {
        return;
      }

      var messageText = types.TextMessage(
          showStatus: true,
          author:
              types.User(id: res.UserId.toString(), firstName: res.UserName),
          id: res.MessageId.toString(),
          type: types.MessageType.text,
          text: res.Content as String);

      _addMessage(messageText);
    }));
  }

  @override
  void dispose() {
    SignalRConnection.hubConnection.off("ReceiveMessage");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _chatName = (ModalRoute.of(context)!.settings.arguments as ScreenArguments)
        .chatGuid as String;
    _userId = (ModalRoute.of(context)!.settings.arguments as ScreenArguments)
        .userId as int;
    _currentUser = types.User(id: _userId.toString());
    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, '/home');
          return true;
        },
        child: Scaffold(
          appBar: isDefaultAppBar
              ? getSearchAppBar(context)
              : getDefaultAppBar(context),
          body: Chat(
            messages: _filterMessages,
            onSendPressed: _handleSendPressed,
            user: _currentUser,
            showUserNames: true,
            showUserAvatars: true,
          ),
        ));
  }

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
      _filterMessages = _messages;
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    var messageContext = MessageContext(
        ChatId: _chatName,
        Content: textMessage.text,
        SendDate: DateTime.now(),
        UserId: _userId,
        ContentType: 1);
    await SignalRConnection.hubConnection
        .send(methodName: "SendMessage", args: [messageContext.toJson()]);
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
              _filterMessages = _messages;
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
            _filterMessages = _messages
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
