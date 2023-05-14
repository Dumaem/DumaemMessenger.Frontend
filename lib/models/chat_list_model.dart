class ChatListModel{
    int id;
    String? chatName;
    String? lastMessage;
    String? senderName;
    int? countOfUnreadMessages;

    ChatListModel(
      {required this.id,
      this.chatName,
      this.lastMessage,
      this.countOfUnreadMessages, this.senderName});
    
    factory ChatListModel.fromJson(Map<String, dynamic> json){
      return ChatListModel(
        id: json['chatId'],
        chatName: json['chatName'],
        lastMessage: json['lastMessage'].fromJson(json['content']).fromJson(json['content']),
        senderName: json['senderName']
      );
    }
}