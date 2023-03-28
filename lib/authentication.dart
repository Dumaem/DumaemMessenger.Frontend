import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Dumaem Messenger",
                    style: TextStyle(
                        fontSize: fontSizeForTitle,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const AuthTextFieldWidget(textForField: "Email"),
            const MarginWidget(),
            const AuthTextFieldWidget(textForField: "Password"),
            const MarginWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width *
                  authenticationPageWidgetWidth,
              child: ElevatedButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(baseBorderRadius))))),
                onPressed: () {
                  //const AlertDialog(content: Text("Выполнен переход"));
                  Navigator.popAndPushNamed(context, '/chats');
                },
                child: const Text("Sign in",
                    style: TextStyle(fontSize: fontSizeForHyperText)),
              ),
            ),
            const MarginWidget(),
            InkWell(
              child: const Text("Sign up?",
                  style: TextStyle(fontSize: fontSizeForHyperText)),
              onTap: () {},
            ),
            const MarginWidget()
          ]),
        ),
      ),
    );
  }
}

class AuthTextFieldWidget extends StatelessWidget {
  final String textForField;
  const AuthTextFieldWidget({super.key, required this.textForField});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * authenticationPageWidgetWidth,
      child: TextField(
        decoration: InputDecoration(
            label: Text(textForField),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(baseBorderRadius),
                borderSide: const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(baseBorderRadius),
                borderSide: const BorderSide()),
            prefixIcon: const Icon(Icons.email)),
      ),
    );
  }
}
