import 'dart:convert';

class ChatListModel {
  int id;
  String? chatGName;
  String? chatName;
  String? lastMessage;
  String? senderName;
  int? countOfUnreadMessages;

  ChatListModel(
      {required this.id,
      this.chatName,
      this.lastMessage,
      this.countOfUnreadMessages,
      this.senderName,
      this.chatGName});

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
        id: json['chatId'],
        chatName: json['chatName'],
        lastMessage: json['lastMessage'] != null
            ? json['lastMessage']['content']['content']
            : null,
        senderName: json['senderName'],
        chatGName: json['']);
  }
}
