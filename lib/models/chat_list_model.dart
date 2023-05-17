import 'dart:convert';

class ChatListModel {
  int id;
  String? chatName;
  String? lastMessage;
  String? senderName;
  int? countOfUnreadMessages;

  ChatListModel({
    required this.id,
    this.chatName,
    this.lastMessage,
    this.countOfUnreadMessages,
    this.senderName,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      id: json['chatId'],
      chatName: json['chatName'],
      lastMessage: json['lastMessage'] != null
          ? json['lastMessage']['content']['content']
          : null,
      senderName: json['senderName'],
    );
  }

  factory ChatListModel.onChatCreatedFromJson(Map<String, dynamic> json) {
    return ChatListModel(
        id: json['id'],
        chatName: json['groupName'],
        lastMessage: null,
        senderName: null);
  }
}
