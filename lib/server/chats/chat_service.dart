import '../../models/chat_list_model.dart';
import '../dio_http_client.dart';
import '../global_variables.dart';

class ChatService{
  Future<List<ChatListModel>> GetChatsView() async
  {
    List<ChatListModel> data = List.empty(); 

    int userId = int.parse(await storage.read(key: 'id') as String);
    Map<String, int> queryParameters = {
      "id": userId
    };
    var response = await DioHttpClient.dio.get('Chat/get-user-chats-by-id', queryParameters: queryParameters);

    for(var jsonData in response.data)
    {
      data.add(ChatListModel.fromJson(jsonData));
    }
    return data;
  }
}