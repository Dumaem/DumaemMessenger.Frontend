import 'package:dumaem_messenger/models/message_context.dart';

import '../../models/chat_list_model.dart';
import '../dio_http_client.dart';
import '../global_variables.dart';

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

  Future<List<MessageContext>> getChatMessages(
      String chatName, int count, int page) async {
    List<MessageContext> data = List.empty(growable: true);
    Map<String, dynamic> queryParameters = {
      'chatName': chatName,
      'count':count,
      'page':page
    };
    var response = await DioHttpClient.dio
        .get('Message', queryParameters: queryParameters);

    for (var jsonData in response.data) {
      data.add(MessageContext.fromJson(jsonData));
    }
    return data;
  }
}
