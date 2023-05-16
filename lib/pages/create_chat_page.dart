import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';
import '../server/user/user_service.dart';
import '../widgets/user_card.dart';

List<UserModel>? usersList = List.empty(growable: true);

class CreateChatPage extends StatefulWidget {
  const CreateChatPage({super.key});

  @override
  _CreateChatPageState createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  final UserService _userService = UserService();
  Future<List<UserModel>>? _getUsers;
  List<UserModel>? filterUsers = usersList;

  List<UserModel> selectedUsers = [];
  bool isDefaultAppBar = true;
  String searchText = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _getUsers = _userService.getAllUsersView();
    return Scaffold(
      appBar: isDefaultAppBar
          ? getSearchAppBar(context)
          : getDefaultAppBar(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.arrow_forward)),
      body: FutureBuilder<List<UserModel>>(
        future: _getUsers,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            usersList = snapshot.data;
            filterUsers = usersList;

            return Stack(
              children: [
                ListView.builder(
                  itemCount: filterUsers!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: selectedUsers.isNotEmpty ? 90 : 10,
                      );
                    }
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (filterUsers![index - 1].select == true) {
                            selectedUsers.remove(filterUsers![index - 1]);
                            filterUsers![index - 1].select = false;
                          } else {
                            selectedUsers.add(filterUsers![index - 1]);
                            filterUsers![index - 1].select = true;
                          }
                        });
                      },
                      child: UserCard(
                        user: filterUsers![index - 1],
                      ),
                    );
                  },
                ),
                selectedUsers.isNotEmpty
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              height: 75,
                              color: Colors.amberAccent,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filterUsers?.length,
                                itemBuilder: (context, index) {
                                  if (filterUsers![index].select == true) {
                                    return InkWell(
                                      onTap: () {
                                        setState(
                                          () {
                                            selectedUsers
                                                .remove(filterUsers![index]);
                                            filterUsers![index].select = false;
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Stack(
                                              children: const [
                                                CircleAvatar(
                                                  radius: 23,
                                                  child: Text("D"),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    radius: 11,
                                                    child: Icon(
                                                      Icons.clear,
                                                      color: Colors.white,
                                                      size: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            const Text(
                                              'Riaz',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return Container();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/home');
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "New chat",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Add participants",
            style: TextStyle(
              fontSize: 13,
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isDefaultAppBar = !isDefaultAppBar;
              filterUsers = usersList;
            });
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
      ],
    );
  }

  AppBar getDefaultAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              searchController.clear();
              searchText = "";
              isDefaultAppBar = !isDefaultAppBar;
            });
          },
          icon: const Icon(Icons.close),
        )
      ],
      title: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
            filterUsers = usersList
                ?.where((element) =>
                    element.name.toLowerCase().contains(searchText))
                .toList();
          });
        },
        decoration:
            InputDecoration(label: Text(S.of(context).participant_title)),
      ),
    );
  }
}
