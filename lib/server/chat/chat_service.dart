import 'dart:convert';

import 'package:dumaem_messenger/models/message_context.dart';

import '../../models/chat_list_model.dart';
import '../../models/message_list_result.dart';
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

  Future<ListResult> getChatMessages(
      String chatName, int count, int page) async {
    List<types.Message> data = List.empty(growable: true);
    Map<String, dynamic> queryParameters = {
      'chatName': chatName,
      'count': count,
      'page': page
    };
    var response = await DioHttpClient.dio
        .get('Message', queryParameters: queryParameters);
    for (var jsonData in response.data['items']) {
      var messageContext = MessageContext(
        ChatId: chatName,
        Content: jsonData['content']['content'],
        UserId: jsonData['senderId'],
        SendDate: DateTime.parse(jsonData['dateOfDispatch']),
        ForwardedMessageId: jsonData['forwardedMessageId'],
        RepliedMessageId: jsonData['repliedMessageId'],
        MessageId: jsonData['id']
      );
      data.add(types.TextMessage(
          showStatus: true,
          author: types.User(
              id: messageContext.UserId.toString(),
              firstName: messageContext.UserName),
          id: messageContext.MessageId.toString(),
          type: types.MessageType.text,
          text: messageContext.Content as String));
    }
    return ListResult(items: data, totalItemsCount: response.data['totalItemsCount']);
  }

  Future<ListResult> getChatMessagesFromCount(
      String chatName, int count, int page, int initialCount) async {
    List<types.Message> data = List.empty(growable: true);
    Map<String, dynamic> queryParameters = {
      'chatName': chatName,
      'count': count,
      'page': page,
      'initialCount':initialCount
    };
    var response = await DioHttpClient.dio
        .get('Message', queryParameters: queryParameters);
    for (var jsonData in response.data['items']) {
      var messageContext = MessageContext(
        ChatId: chatName,
        Content: jsonData['content']['content'],
        UserId: jsonData['senderId'],
        SendDate: DateTime.parse(jsonData['dateOfDispatch']),
        ForwardedMessageId: jsonData['forwardedMessageId'],
        RepliedMessageId: jsonData['repliedMessageId'],
        MessageId: jsonData['id']
      );
      data.add(types.TextMessage(
          showStatus: true,
          author: types.User(
              id: messageContext.UserId.toString(),
              firstName: messageContext.UserName),
          id: messageContext.MessageId.toString(),
          type: types.MessageType.text,
          text: messageContext.Content as String));
    }
    return ListResult(items: data, totalItemsCount: response.data['totalItemsCount']);
  }
}
