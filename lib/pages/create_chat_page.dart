import 'package:flutter/material.dart';

class CreateChatPage extends StatefulWidget {
  const CreateChatPage({Key? key}) : super(key: key);

  @override
  State<CreateChatPage> createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
        ),
      )
    );
  }
}

