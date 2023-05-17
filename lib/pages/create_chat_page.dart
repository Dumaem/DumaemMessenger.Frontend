import 'package:dumaem_messenger/widgets/user_card.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class CreateChatPage extends StatefulWidget {
  const CreateChatPage({super.key});

  @override
  _CreateChatPageState createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  final List<UserModel> selectedUsers = [];

  final TextEditingController _chatNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание чата'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _chatNameController,
            decoration: const InputDecoration(
              hintText: 'Введите название чата',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return UserCard(user: selectedUsers[index]);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement chat creation logic
            },
            child: Text('Создать'),
          ),
        ],
      ),
    );
  }
}
