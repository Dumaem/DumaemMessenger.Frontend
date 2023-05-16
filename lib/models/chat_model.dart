class ChatModel {
  String name;
  String status;
  bool select = false;

  ChatModel({
    required this.name,
    required this.status,
    this.select = false,
  });
}