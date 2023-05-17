class ChatModel {
  List<int> participants = List<int>.empty(growable: true);
  String groupName = "";
  bool isPersonal = true;

  ChatModel({
    required this.participants,
    required this.groupName,
    required this.isPersonal,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data =  {
      'participantsIds': participants,
      'isPersonal': isPersonal,
      'groupName': groupName,
    };

    return data;
  }
}
