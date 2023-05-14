import 'dart:ffi';

class MessageContext {
  late int ContentType;
  late String Content;
  late int UserId;
  late DateTime SendDate;
  late String ChatId;
  late Int64? ForwardedMessageId;
  late Int64? RepliedMessageId;
}
