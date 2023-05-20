import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/user_model.dart';
import '../properties/config.dart';
import '../server/user/user_service.dart';
import '../widgets/text_field.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({Key? key}) : super(key: key);

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final UserService _userService = UserService();
  late Future<UserModel> _getCurrentUser;

  @override
  void initState() {
    _getCurrentUser = _userService.getUserView();
    super.initState();
  }

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
      ),
      body: FutureBuilder<UserModel>(
        future: _getCurrentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(alignment: Alignment.center, child: LoadingAnimationWidget.twoRotatingArc(
                  color: Colors.white,
                  size: 100,
                ),);
          } else {
            nameController.text = snapshot.data!.name;
            usernameController.text = snapshot.data!.username as String;
            emailController.text = snapshot.data!.email;

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: sizedBoxHeight),
                TextFieldWidget(
                  label: 'Full Name',
                  text: snapshot.data!.name,
                  onChanged: (name) {},
                  fieldController: nameController,
                ),
                const SizedBox(height: sizedBoxHeight),
                TextFieldWidget(
                  label: 'Username',
                  text: snapshot.data!.username as String,
                  onChanged: (username) {},
                  fieldController: usernameController,
                ),
                const SizedBox(height: sizedBoxHeight),
                TextFieldWidget(
                  label: 'Email',
                  text: snapshot.data!.email,
                  onChanged: (email) {},
                  fieldController: emailController,
                ),
                const SizedBox(height: sizedBoxHeight),
                IconButton(
                  onPressed: () async {
                    await _userService.putUserData(nameController.text,
                        usernameController.text, emailController.text);

                    Navigator.popAndPushNamed(context, '/home');
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
