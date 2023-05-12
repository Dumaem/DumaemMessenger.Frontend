import 'package:dumaem_messenger/generated/l10n.dart';
import 'package:dumaem_messenger/pages/registration.dart';
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
  Widget build(BuildContext) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const MarginWidget(),
            const Icon(
              Icons.lock,
              size: 100,
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
                try {
                  var response = await DioHttpClient.dio
                      .post('Authorization/login', data: {
                    'email': _emailController.text,
                    'password': _passwordController.text
                  });
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
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//       child: SingleChildScrollView(
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 S.of(context).app_bar_title,
//                 style: const TextStyle(
//                     fontSize: fontSizeForTitle, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//           AuthTextFieldWidget(
//             textForField: S.of(context).email_title,
//             fieldController: _emailController,
//           ),
//           const MarginWidget(),
//           AuthTextFieldWidget(
//               textForField: S.of(context).password_title,
//               fieldController: _passwordController),
//           const MarginWidget(),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.06,
//             width: MediaQuery.of(context).size.width *
//                 authenticationPageWidgetWidth,
//             child: ElevatedButton(
//               style: const ButtonStyle(
//                   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(
//                           Radius.circular(baseBorderRadius))))),
//               onPressed: () async {
//                 try {
//                   var response = await DioHttpClient.dio
//                       .post('Authorization/login', data: {
//                     'email': _emailController.text,
//                     'password': _passwordController.text
//                   });
//                   Navigator.popAndPushNamed(context, '/chats');
//                 } catch (exception) {
//                   StatusAlert.show(
//                     context,
//                     duration: const Duration(seconds: 2),
//                     title: 'Ошибка!',
//                     subtitle: 'Пользователя с такими данными не существует!',
//                     configuration: const IconConfiguration(icon: Icons.error),
//                     maxWidth: MediaQuery.of(context).size.width * 0.8,
//                   );
//                 }

//                 //const AlertDialog(content: Text("Выполнен переход"));
//               },
//               child: Text(S.of(context).sign_in_title,
//                   style: const TextStyle(fontSize: fontSizeForHyperText)),
//             ),
//           ),
//           const MarginWidget(),
//           InkWell(
//             child: Text("${S.of(context).sign_up_title}?",
//                 style: const TextStyle(fontSize: fontSizeForHyperText)),
//             onTap: () {
//               Navigator.popAndPushNamed(context, '/registration');
//             },
//           ),
//           const MarginWidget()
//         ]),
//       ),
//     ),
//   );
// }
//}

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

// class AuthTextFieldWidget extends StatelessWidget {
//   final String textForField;
//   final TextEditingController fieldController;
//   const AuthTextFieldWidget(
//       {super.key, required this.textForField, required this.fieldController});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * authenticationPageWidgetWidth,
//       child: TextField(
//         controller: fieldController,
//         decoration: InputDecoration(
//             label: Text(textForField),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(baseBorderRadius),
//                 borderSide: const BorderSide()),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(baseBorderRadius),
//                 borderSide: const BorderSide()),
//             prefixIcon: const Icon(Icons.email)),
//       ),
//     );
//   }
// }
