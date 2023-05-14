import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import '../generated/l10n.dart';
import 'authorization.dart';
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
  Widget build(BuildContext) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const MarginWidget(),
            Text(
              S.of(context).app_bar_title,
              style: const TextStyle(
                  fontSize: fontSizeForTitle, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            AuthTextFieldWidget(
              controller: _nameController,
              hintText: S.of(context).name_title,
              obscureText: false,
            ),
            const SmallMarginWidget(),
            AuthTextFieldWidget(
              controller: _userNameController,
              hintText: S.of(context).username_title,
              obscureText: false,
            ),
            const SmallMarginWidget(),
            AuthTextFieldWidget(
              controller: _emailController,
              hintText: S.of(context).email_title,
              obscureText: false,
            ),
            const SmallMarginWidget(),
            AuthTextFieldWidget(
              controller: _passwordController,
              hintText: S.of(context).password_title,
              obscureText: false,
            ),
            const MarginWidget(),
            GestureDetector(
              onTap: () async {
                await registrateUser(context);
              },
              child: Container(
                padding: const EdgeInsets.all(textPadding),
                margin: const EdgeInsets.symmetric(horizontal: textPadding),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    S.of(context).sign_up_title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SmallMarginWidget(),
            InkWell(
              child: Text("${S.of(context).sign_in_title}?",
                  style: const TextStyle(fontSize: fontSizeForHyperText)),
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              },
            ),
          ],
        ),
      )),
    ));
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
