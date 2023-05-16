import 'dart:ffi';

import 'package:dumaem_messenger/models/user.dart';
import 'package:dumaem_messenger/server/global_functions.dart';

class MessageContext {
  late int? ContentType;
  late int? MessageId;
  late String? Content;
  late String? ChatName;
  late int? UserId;
  late String? UserName;
  late DateTime? SendDate;
  late String? ChatId;
  late Int64? ForwardedMessageId;
  late Int64? RepliedMessageId;

  MessageContext(
      {this.ChatId,
      this.Content,
      this.ContentType,
      this.ForwardedMessageId,
      this.RepliedMessageId,
      this.SendDate,
      this.UserId,
      this.UserName,
      this.MessageId});

  factory MessageContext.fromJson(Map<String, dynamic> json) {
    return MessageContext(
      ContentType: json['contentType'],
      ChatId: json['chatId'],
      Content: json['content'],
      SendDate: DateTime.parse(json['sendDate']),
      ForwardedMessageId: json['forwardedMessageId'],
      RepliedMessageId: json['repliedMessageId'],
      UserId: json['userId'],
      MessageId: json['id'],
      UserName: json['user']['name'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'user': null,
      'chatId': ChatId,
      'sendDate':GlobalFunctions.formatISOTime(SendDate as DateTime),
      'content': Content,
      'contentType': 1,
      'userId': UserId,
      'repliedMessageId': null,
      'forwardedMessageId': null,
      'id':0
    };
  }
}
