import 'package:dumaem_messenger/widgets/text_field.dart';
import 'package:dumaem_messenger/widgets/user_card.dart';
import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';
import '../properties/create_chat_page_arguments.dart';
import '../server/global_variables.dart';
import '../server/signalr_connection.dart';

class CreateChatPage extends StatefulWidget {
  const CreateChatPage({super.key});

  @override
  _CreateChatPageState createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  List<UserModel> selectedUsers = [];

  final TextEditingController _chatNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    selectedUsers =
        (ModalRoute.of(context)!.settings.arguments as CreateChatPageArguments)
            .users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create chat'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          TextFieldWidget(
              label: 'Input chat name',
              text: '',
              onChanged: (String value) {},
              fieldController: _chatNameController),
          Expanded(
            child: ListView.builder(
              itemCount: selectedUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return UserCard(user: selectedUsers[index]);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var participantsIds = selectedUsers.map((e) => e.id).toList();
              participantsIds
                  .add(int.parse(await storage.read(key: userKey) as String));

              await SignalRConnection.hubConnection
                  .send(methodName: "CreateChat", args: [
                participantsIds,
                _chatNameController.text,
              ]);

              Navigator.popAndPushNamed(context, '/home');
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }
}
