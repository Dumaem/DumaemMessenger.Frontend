import 'package:dumaem_messenger/properties/chat_page_arguments.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/server/chat/chat_service.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:dumaem_messenger/server/signalr_connection.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../generated/l10n.dart';
import '../main.dart';
import '../models/chat_list_model.dart';

List<ChatListModel>? chatsList = List.empty(growable: true);

class ChatsPage extends KFDrawerContent {
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool isDefaultAppBar = true;
  String searchText = "";

  @override
  void initState() {
    SignalRConnection.hubConnection.on('ChatCreated', (chat) {
      setState(() {});
    });
    SignalRConnection.hubConnection.on('MemberAdded', (arguments) {
      setState(() {});
    });
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  List<ChatListModel>? filterChats = chatsList;

  final ChatService _chatService = ChatService();
  Future<List<ChatListModel>>? _getChats;

  @override
  Widget build(BuildContext context) {
    _getChats = _chatService.getChatsView();
    return Scaffold(
        appBar: isDefaultAppBar
            ? getSearchAppBar(context)
            : getDefaultAppBar(context),
        body: FutureBuilder<List<ChatListModel>>(
            future: _getChats,
            builder: (BuildContext context,
                AsyncSnapshot<List<ChatListModel>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.twoRotatingArc(
                    color: Colors.white,
                    size: 100,
                  ),
                );
              } else {
                chatsList = snapshot.data;
                filterChats = chatsList;
                return ListView.builder(
                    itemCount: filterChats!.length,
                    itemBuilder: (context, index) {
                      var lastMessage = "";
                      if (filterChats![index].lastMessage != null) {
                        lastMessage =
                            filterChats![index].lastMessage!.length > 50
                                ? filterChats![index]
                                        .lastMessage!
                                        .substring(0, 47) +
                                    "..."
                                : filterChats![index].lastMessage!;
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(baseBorderRadius),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(baseBorderRadius),
                          ),
                          leading: CircleAvatar(
                            child: Text(
                                filterChats![index].chatName![0].toUpperCase()),
                          ),
                          title: Text(filterChats![index].chatName!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: filterChats![index].lastMessage != null
                              ? Text(
                                  "${filterChats![index].senderName}: ${lastMessage}")
                              : const Text(""),
                          onTap: () async {
                            Navigator.pushNamed(context, '/chat',
                                arguments: ScreenArguments(
                                    filterChats![index].chatGuid,
                                    int.parse(await storage.read(key: userKey)
                                        as String)));
                          },
                        ),
                      );
                    });
              }
            }));
  }

  AppBar getDefaultAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: widget.onMenuPressed,
        icon: const Icon(Icons.menu),
      ),
      title: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
            filterChats = chatsList!
                .where((element) =>
                    element.chatName!.toLowerCase().contains(searchText))
                .toList();
          });
        },
        decoration: InputDecoration(label: Text(S.of(context).chat_name_title)),
      ),
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
    );
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(S.of(context).app_bar_title),
          Flexible(
            child: IconButton(
              onPressed: () async {
                await storage.write(
                  key: "isDarkTheme",
                  value: (isLightTheme).toString(),
                );
                setState(() {
                  isLightTheme = !isLightTheme;
                  if (isLightTheme) {
                    Messenger.of(context).changeTheme(ThemeMode.light);
                  } else {
                    Messenger.of(context).changeTheme(ThemeMode.dark);
                  }
                });
              },
              icon: Icon(isLightTheme ? lightIcon : darkIcon),
            ),
          )
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: widget.onMenuPressed,
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isDefaultAppBar = !isDefaultAppBar;
              filterChats = chatsList;
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
