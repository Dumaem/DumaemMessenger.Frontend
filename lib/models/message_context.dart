import 'dart:ffi';

class MessageContext {
  late int? ContentType;
  late int? MessageId;
  late String? Content;
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
      UserName: json['user']['name'] 
    );
  }
}
