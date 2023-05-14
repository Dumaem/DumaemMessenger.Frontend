import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import '../generated/l10n.dart';
import '../server/global_variables.dart';
import '../server/signalr_connection.dart';

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
              textForField: S.of(context).name_tile,
              fieldController: _nameController,
            ),
            const MarginWidget(),
            AuthTextFieldWidget(
              textForField: S.of(context).username_title,
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
                  await registrateUser(context);
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

  Future<void> registrateUser(BuildContext context) async {
    try {
      final response =
          await DioHttpClient.dio.post('/Authorization/register', data: {
        'name': _nameController.text,
        'username': _userNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text
      });

      await storage.write(
          key: accessTokenKey, value: response.data['accessToken']);
      await storage.write(
          key: refreshTokenKey, value: response.data['refreshToken']);

      await SignalRConnection.hubConnection.start();
      Navigator.popAndPushNamed(context, '/home');
    } catch (ex) {
      StatusAlert.show(
        context,
        duration: const Duration(seconds: 2),
        title: 'Ошибка!',
        subtitle:
            'При регистрации произошла ошибка!\nПопробуйте ввести другие данные!',
        configuration: const IconConfiguration(icon: Icons.error),
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      );
    }
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
