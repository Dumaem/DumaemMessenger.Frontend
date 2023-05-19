import 'dart:convert';
import 'dart:math';

import 'package:dumaem_messenger/models/message_list_result.dart';
import 'package:dumaem_messenger/models/message_context.dart';
import 'package:dumaem_messenger/server/chat/chat_service.dart';
import 'package:dumaem_messenger/server/signalr_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mutex/mutex.dart';

import '../generated/l10n.dart';
import '../models/chat_model.dart';
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
  TextEditingController searchController = TextEditingController();
  List<types.Message> _messages = [];
  List<types.Message> _filterMessages = [];
  String searchText = "";
  final _chatService = ChatService();
  Future<ListResult>? _getMessages;
  Future<ChatModel>? _getChatInfo;
  late String _chatName;
  late int _userId;
  int _page = 0;
  final int _count = 200;
  int _initalCount = 0;
  int _maxPageNum = 0;
  bool isDefaultAppBar = true;
  bool _loaded = false;
  bool _sendRequest = true;
  late types.User _currentUser;
  late ChatModel _currentChat;
  final _mutex = Mutex();
  List<String> m = List.empty(growable: true);

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
    if (!_loaded) {
      
      _getMessages = _chatService.getChatMessages(_chatName, _count, _page);
      _page += 1;
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, '/home');
          return true;
        },
        child: FutureBuilder<ListResult>(
            future: _getMessages,
            builder:
                (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
              if (!snapshot.hasData) {
                return Container(alignment: Alignment.center, child: LoadingAnimationWidget.twoRotatingArc(
                  color: Colors.black,
                  size: 100,
                ),
                color: Colors.white,);
              } else {
                if (!_loaded) {
                  _messages = snapshot.data!.items;
                  _filterMessages = _messages;
                  _initalCount = snapshot.data!.totalItemsCount;
                  _loaded = true;
                }
                return Scaffold(
                  appBar: isDefaultAppBar
                      ? getSearchAppBar(context)
                      : getDefaultAppBar(context),
                  body: Chat(
                    messages: _filterMessages,
                    onSendPressed: _handleSendPressed,
                    user: _currentUser,
                    showUserNames: true,
                    showUserAvatars: true,
                    onEndReached: _handleEndReached,
                  ),
                );
              }
            }));
  }

  Future<void> _addToList(List<types.Message> messages, bool isFromUser) async {
    m.addAll(messages.map((e) => e.id));
    print(m);
    //await _mutex.acquire();
    try {
      if (isFromUser) {
        _messages.insert(0, messages[0]);
      } else {
        _messages.addAll(messages);
      }
    } finally {
      //_mutex.release();
    }
  }

  Future<void> _handleEndReached() async {
    final ListResult? res;
    if (!_sendRequest) {
      return;
    } else {
      res = await _chatService.getChatMessagesFromCount(
          _chatName, _count, _page, _initalCount);
      setState(() {
        _addToList(res!.items, false);
        _maxPageNum = res.totalItemsCount ~/ _count +
            (res.totalItemsCount % _count != 0 ? 1 : 0);
        _page = _page + 1;

        if (_maxPageNum <= _page) {
          _sendRequest = false;
        }
      });
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _addToList(<types.Message>[message], true);
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
    _getChatInfo = _chatService.getChatInfo(_chatName);
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/home');
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: FutureBuilder(
        future: _getChatInfo,
        builder: (BuildContext context, AsyncSnapshot<ChatModel> snapshot) {
          if(!snapshot.hasData)
          {
            return Container(alignment: Alignment.center, child: LoadingAnimationWidget.twoRotatingArc(
                  color: Colors.white,
                  size: 100,
                ),);
          }
          else
          {
            _currentChat = snapshot.data!;
              return ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/chatInfo');
              },
              leading: CircleAvatar(
                child: Text(_currentChat.groupName![0]),
              ),
              title: Text(_currentChat.groupName!),
            );
          }
        },
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
