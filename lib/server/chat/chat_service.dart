import 'dart:convert';

import 'package:dumaem_messenger/models/message_context.dart';
import 'package:flutter/services.dart';

import '../../models/chat_list_model.dart';
import '../../models/chat_model.dart';
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

  types.TextMessage convertToTextMessage(MessageContext messageContext) {
    return types.TextMessage(
        showStatus: true,
        author: types.User(
            id: messageContext.UserId.toString(),
            firstName: messageContext.UserName),
        id: messageContext.MessageId.toString(),
        type: types.MessageType.text,
        text: messageContext.Content as String);
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
      var messageContext =
          MessageContext.chatMessagefromJson(jsonData, chatName);
      data.add(convertToTextMessage(messageContext));
    }
    return ListResult(
        items: data, totalItemsCount: response.data['totalItemsCount']);
  }

  Future<ListResult> getChatMessagesFromCount(
      String chatName, int count, int page, int initialCount) async {
    List<types.Message> data = List.empty(growable: true);
    Map<String, dynamic> queryParameters = {
      'chatName': chatName,
      'count': count,
      'page': page,
      'initialCount': initialCount
    };
    var response = await DioHttpClient.dio
        .get('Message/getFromCount', queryParameters: queryParameters);
    for (var jsonData in response.data['items']) {
      var messageContext =
          MessageContext.chatMessagefromJson(jsonData, chatName);
      data.add(convertToTextMessage(messageContext));
    }
    return ListResult(
        items: data, totalItemsCount: response.data['totalItemsCount']);
  }

  Future<ChatModel> getChatInfo(String chatName) async {
    Map<String, dynamic> queryParameters = {
      'name': chatName,
    };
    var response = await DioHttpClient.dio
        .get('Chat/get-chat-by-name', queryParameters: queryParameters);
    
    return ChatModel.fromJson(response.data);
  }
}
