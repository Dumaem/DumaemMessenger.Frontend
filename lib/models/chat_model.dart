class ChatModel {
  List<int>? participants = List<int>.empty(growable: true);
  String groupName = "";
  bool isPersonal = true;

  ChatModel({
    this.participants,
    required this.groupName,
    required this.isPersonal,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        groupName: json['groupName'],
        isPersonal: json['isPersonal'],);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data =  {
      'participantsIds': participants,
      'isPersonal': isPersonal,
      'groupName': groupName,
    };

    return data;
  }
}
