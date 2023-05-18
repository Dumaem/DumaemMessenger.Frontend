import 'dart:convert';

class ChatListModel {
  int id;
  String? chatGuid;
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
      this.chatGuid});

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
        id: json['chatId'],
        chatName: json['chatName'],
        lastMessage: json['lastMessage'] != null
            ? json['lastMessage']['content']['content']
            : null,
        senderName: json['senderName'],
        chatGuid: json['chatGuid']);
  }

  factory ChatListModel.onChatCreatedFromJson(Map<String, dynamic> json) {
    return ChatListModel(
        id: json['id'],
        chatName: json['groupName'],
        lastMessage: null,
        senderName: null);
  }
}
