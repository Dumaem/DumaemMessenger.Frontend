import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:dumaem_messenger/server/http_client.dart';
import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).app_bar_title,
                  style: const TextStyle(
                      fontSize: fontSizeForTitle, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            AuthTextFieldWidget(
              textForField: S.of(context).email_title,
              fieldController: _nameController,
            ),
            const MarginWidget(),
            AuthTextFieldWidget(
              textForField: S.of(context).email_title,
              fieldController: _userNameController,
            ),
            const MarginWidget(),
            AuthTextFieldWidget(
              textForField: S.of(context).email_title,
              fieldController: _emailController,
            ),
            const MarginWidget(),
            AuthTextFieldWidget(
                textForField: S.of(context).password_title,
                fieldController: _passwordController),
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
                onPressed: () async {
                  //const AlertDialog(content: Text("Выполнен переход"));
                  var response = await DioHttpClient.dio
                      .post('Authorization/registration', data: {
                    'email': _emailController.text,
                    'password': _passwordController.text
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.popAndPushNamed(context, '/chats');
                },
                child: Text(S.of(context).sign_up_title,
                    style: const TextStyle(fontSize: fontSizeForHyperText)),
              ),
            ),
            const MarginWidget(),
            InkWell(
              child: Text("${S.of(context).sign_in_title}?",
                  style: const TextStyle(fontSize: fontSizeForHyperText)),
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              },
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
  final TextEditingController fieldController;
  const AuthTextFieldWidget(
      {super.key, required this.textForField, required this.fieldController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * authenticationPageWidgetWidth,
      child: TextField(
        controller: fieldController,
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
