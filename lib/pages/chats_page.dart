import 'package:dio/dio.dart';
import 'package:dumaem_messenger/pages/chat_info_page.dart';
import 'package:dumaem_messenger/properties/chat_page_arguments.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/server/chat/chat_service.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:status_alert/status_alert.dart';

import '../generated/l10n.dart';
import '../models/chat_list_model.dart';

List<ChatListModel>? chatsList = List.empty(growable: true);

class ChatsPage extends KFDrawerContent {
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool isDefaultAppBar = true;
  String searchText = "";

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
                return const CircularProgressIndicator();
              } else {
                chatsList = snapshot.data;
                filterChats = chatsList;
                return ListView.builder(
                  itemCount: filterChats!.length,
                  itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(baseBorderRadius),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(baseBorderRadius),
                      ),
                      leading: CircleAvatar(
                        child: Text(
                            filterChats![index].chatName![0].toUpperCase()),
                      ),
                      title: Text(filterChats![index].chatName!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: filterChats![index].lastMessage != null
                          ? Text(
                              "${filterChats![index].senderName}: ${filterChats![index].lastMessage!}")
                          : const Text(""),
                      onTap: () async{
                        Navigator.pushNamed(context, '/chat',
                            arguments:
                                ScreenArguments(filterChats![index].chatGuid, int.parse(await storage.read(key: userKey) as String)));
                      },
                    ),
                  );
                });
              }
            }));
  }

  AppBar getDefaultAppBar(BuildContext context) {
    return AppBar(
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: widget.onMenuPressed,
          ),
        ),
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
      title: Text(S.of(context).app_bar_title),
      centerTitle: true,
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: widget.onMenuPressed,
          ),
        ),
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