class AddingUserToChatModel {
  String name;
  String status;
  bool select = false;

  AddingUserToChatModel({
    required this.name,
    required this.status,
    this.select = false,
  });
}