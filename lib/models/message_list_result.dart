import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class ListResult{
  int totalItemsCount;
  List<types.Message> items;

  ListResult({required this.items, required this.totalItemsCount});
}