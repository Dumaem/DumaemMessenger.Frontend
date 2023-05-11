import 'package:dumaem_messenger/generated/l10n.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:dumaem_messenger/server/http_client.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
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
                  try {
                    var response = await DioHttpClient.dio
                        .post('Authorization/login', data: {
                      'email': _emailController.text,
                      'password': _passwordController.text
                    });
                    Navigator.popAndPushNamed(context, '/chats');
                  } catch (exception) {
                    StatusAlert.show(
                      context,
                      duration: const Duration(seconds: 2),
                      title: 'Ошибка!',
                      subtitle: 'Пользователя с такими данными не существует!',
                      configuration: const IconConfiguration(icon: Icons.error),
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    );
                  }

                  //const AlertDialog(content: Text("Выполнен переход"));
                  Navigator.popAndPushNamed(context, '/home');
                },
                child: Text(S.of(context).sign_in_title,
                    style: const TextStyle(fontSize: fontSizeForHyperText)),
              ),
            ),
            const MarginWidget(),
            InkWell(
              child: Text("${S.of(context).sign_up_title}?",
                  style: const TextStyle(fontSize: fontSizeForHyperText)),
              onTap: () {
                Navigator.popAndPushNamed(context, '/registration');
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
