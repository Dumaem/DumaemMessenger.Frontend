import 'package:dumaem_messenger/models/message_context.dart';

import '../../models/chat_list_model.dart';
import '../../pages/chat.dart';
import '../dio_http_client.dart';
import '../global_variables.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatService {
  Future<List<ChatListModel>> getChatsView() async {
    List<ChatListModel> data = List.empty(growable: true);

    int userId = int.parse(await storage.read(key: userKey) as String);
    Map<String, int> queryParameters = {"id": userId};
    var response = await DioHttpClient.dio
        .get('Chat/get-user-chats-by-id', queryParameters: queryParameters);

    for (var jsonData in response.data) {
      data.add(ChatListModel.fromJson(jsonData));
    }
    return data;
  }

  Future<List<types.Message>> getChatMessages() async {
    List<Message> data = List.empty(growable: true);
    int userId = int.parse(await storage.read(key: userKey) as String);
    Map<String, int> queryParameters = {"id": userId};
    var response = await DioHttpClient.dio
        .get('Chat/get-user-chats-by-id', queryParameters: queryParameters);
  }
}
