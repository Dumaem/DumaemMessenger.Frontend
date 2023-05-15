import 'package:dumaem_messenger/generated/l10n.dart';
import 'package:dumaem_messenger/pages/registration.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import '../server/signalr_connection.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
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
            Image.asset(
              'lib/images/logo.png',
              width: 100,
            ),
            const MarginWidget(),
            Text(
              S.of(context).app_bar_title,
              style: const TextStyle(
                  fontSize: fontSizeForTitle, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            AuthTextFieldWidget(
              controller: _emailController,
              hintText: S.of(context).email_title,
              obscureText: false,
            ),
            const SmallMarginWidget(),
            AuthTextFieldWidget(
              controller: _passwordController,
              hintText: S.of(context).password_title,
              obscureText: true,
            ),
            const MarginWidget(),
            GestureDetector(
              onTap: () async {
                await authorizeUser(context);
              },
              child: Container(
                padding: const EdgeInsets.all(textPadding),
                margin: const EdgeInsets.symmetric(horizontal: textPadding),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(baseBorderRadius),
                ),
                child: Center(
                  child: Text(
                    S.of(context).sign_in_title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeForHyperText,
                    ),
                  ),
                ),
              ),
            ),
            const SmallMarginWidget(),
            InkWell(
              child: Text("${S.of(context).sign_up_title}?",
                  style: const TextStyle(fontSize: fontSizeForHyperText)),
              onTap: () {
                Navigator.popAndPushNamed(context, '/registration');
              },
            ),
          ],
        ),
      )),
    ));
  }

  Future<void> authorizeUser(BuildContext context) async {
    try {
      var response = await DioHttpClient.dio.post('Authorization/login', data: {
        'email': _emailController.text,
        'password': _passwordController.text
      });
      await storage.write(
          key: accessTokenKey, value: response.data['accessToken']);
      await storage.write(
          key: refreshTokenKey, value: response.data['refreshToken']);

      await SignalRConnection.hubConnection.start();
      Navigator.popAndPushNamed(context, '/home');
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
