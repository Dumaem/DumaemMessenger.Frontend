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
              children: const [Text("DumaemMessenger")],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const AuthTextFieldWidget(
              textForField: "Email",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const AuthTextFieldWidget(
              textForField: "Password",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
                  //backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                ),
                onPressed: () {
                  const AlertDialog(content: Text("Выполнен переход"));
                  Navigator.popAndPushNamed(context, '/home');
                },
                child: const Text("Sign in"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            InkWell(
              child: const Text("Sign up?"),
              onTap: () {},
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
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
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
            label: Text(textForField),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide()),
            prefixIcon: const Icon(Icons.email)),
      ),
    );
  }
}
