import 'package:dumaem_messenger/models/user_model.dart';

class ChatModel {
  int id;
  String? groupName = "";
  bool isPersonal = true;
  List<UserModel>? users;

  ChatModel(
      {required this.id,
      required this.groupName,
      required this.isPersonal,
      this.users});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['id'],
        groupName: json['groupName'],
        isPersonal: json['isPersonal'],
        users: null);
  }
}
