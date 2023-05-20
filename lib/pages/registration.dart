import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:dumaem_messenger/server/global_functions.dart';
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: () async {
                  await registrateUser(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(textPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).sign_up_title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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

      GlobalFunctions.writeUserInfo(response);

      await SignalRConnection.hubConnection.start();
      Navigator.popAndPushNamed(context, '/home');
    } catch (ex) {
      StatusAlert.show(
        padding: const EdgeInsets.all(alertPadding),
        margin: const EdgeInsets.all(alertPadding),
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
  final controller;
  final String hintText;
  final bool obscureText;

  const AuthTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: textPadding),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
