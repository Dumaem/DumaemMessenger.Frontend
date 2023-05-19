import 'package:dumaem_messenger/properties/create_chat_page_arguments.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/user_model.dart';
import '../server/user/user_service.dart';
import '../widgets/user_card.dart';

class SelectUsersForNewChatPage extends StatefulWidget {
  const SelectUsersForNewChatPage({super.key});

  @override
  _SelectUsersForNewChatPageState createState() =>
      _SelectUsersForNewChatPageState();
}

class _SelectUsersForNewChatPageState extends State<SelectUsersForNewChatPage> {
  List<UserModel> usersList = List.empty(growable: true);

  final UserService _userService = UserService();
  late List<UserModel>? filterUsers = usersList;

  List<UserModel> selectedUsers = [];
  bool isDefaultAppBar = true;
  String searchText = "";
  TextEditingController searchController = TextEditingController();

  Future<List<UserModel>> _getUsers() async {
    if (usersList.isEmpty) {
      usersList = await _userService.getAllUsersView();
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, '/home');
          return true;
        },
        child: Scaffold(
          appBar: isDefaultAppBar
              ? getSearchAppBar(context)
              : getDefaultAppBar(context),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (selectedUsers.isEmpty) {
                  return;
                }
                Navigator.pushNamed(context, 'createChat',
                    arguments: CreateChatPageArguments(selectedUsers));
              },
              child: const Icon(Icons.arrow_forward)),
          body: FutureBuilder<List<UserModel>>(
            future: _getUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                if (usersList.isEmpty) {
                  usersList = snapshot.data as List<UserModel>;
                  filterUsers = usersList;
                }
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
                                Material(
                                  elevation: 10,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: 85,
                                    child: SizedBox(
                                      height: 75,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: selectedUsers.length,
                                        itemBuilder: (context, index) {
                                          if (selectedUsers[index].select ==
                                              true) {
                                            return InkWell(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    filterUsers!
                                                        .firstWhere((element) =>
                                                            element ==
                                                            selectedUsers[
                                                                index])
                                                        .select = false;

                                                    selectedUsers.remove(
                                                        selectedUsers[index]);
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 23,
                                                          child: Text(
                                                              selectedUsers[
                                                                      index]
                                                                  .name[0]
                                                                  .toUpperCase()),
                                                        ),
                                                        const Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            radius: 11,
                                                            child: Icon(
                                                              Icons.clear,
                                                              color:
                                                                  Colors.white,
                                                              size: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      selectedUsers[index].name,
                                                      style: const TextStyle(
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
        ));
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/chats');
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                .where((element) =>
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
