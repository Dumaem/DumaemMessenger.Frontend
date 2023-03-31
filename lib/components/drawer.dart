import 'package:dumaem_messenger/properties/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            // временная затычка.
            height: MediaQuery.of(context).size.height * 0.26,
            child: DrawerHeader(
              child: UserAccountsDrawerHeader(
                currentAccountPicture: Container(
                  alignment: Alignment.topLeft,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        // временная затычка.
                        "https://sun9-48.userapi.com/impg/3Tr7i0Yi7Edt6tKh2_sgVacRsDu42XGst7phpw/qIdXkvVR5vE.jpg?size=1536x2048&quality=95&sign=b3c6d31138f00b7cde0e1898d5303f3c&type=album"),
                    minRadius: chatCircleAvatarRadius,
                  ),
                ),
                // временная затычка.
                accountName: const Text("Dragon"),
                // временная затычка.
                accountEmail: const Text("asdfasf"),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(baseBorderRadius)),
                otherAccountsPictures: [
                  IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/');
                      })
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Shop"),
            leading: const Icon(Icons.shop),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Info"),
            leading: const Icon(Icons.info),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
