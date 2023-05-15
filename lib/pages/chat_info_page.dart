import 'package:dumaem_messenger/properties/margin.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../properties/config.dart';
import '../tabs/chat_participants_view.dart';
import '../tabs/photos_view.dart';
import '../tabs/videos_view.dart';

class ChatInfoPage extends StatefulWidget {
  const ChatInfoPage({Key? key}) : super(key: key);

  @override
  State<ChatInfoPage> createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {
  final Chat currentChat = chat;

  // tabs
  final List<Widget> tabs = const [
    // chat participants tab
    Tab(
      icon: Icon(Icons.supervised_user_circle_rounded),
    ),
    // photos tab
    Tab(
      icon: Icon(Icons.image),
    ),
    // videos tab
    Tab(
      icon: Icon(Icons.video_collection_rounded),
    ),
  ];

  // tab bar views
  final List<Widget> tabBarViews = const [
    // chat participants view
    ChatParticipantsView(),
    // photos view
    PhotosView(),
    // videos view
    VideosView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 190, 233, 244),
          child: Column(
            children: [
              Column(
                children: [
                  const Margin40(),

                  // appbar with logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // go back button
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/home');
                              },
                            ),
                          ),
                        ),

                        // chat logo
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CircleAvatar(
                            backgroundImage: currentChat.logo,
                            radius: 50,
                          ),
                        ),

                        // settings button
                        Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    dropListWidth,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  icon: const Icon(Icons.more_vert),
                                  items: <String>[
                                    S.of(context).add_member_title,
                                    S.of(context).edit_name_chat_title
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style:
                                            TextStyle(fontSize: smallFontSize),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                ),
                              )
                              // IconButton(
                              //   icon: const Icon(Icons.more_vert),
                              //   onPressed: () {
                              //     Navigator.popAndPushNamed(context, '/home');
                              //   },
                              // ),
                              ),
                        ),
                      ],
                    ),
                  ),

                  const Margin20(),

                  // chat name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentChat.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const Margin10(),

                  // chat name
                  Text(
                    "${currentChat.countParticipants} participants",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),

                  const Margin10(),
                ],
              ),

              // tab bar
              TabBar(tabs: tabs),

              //tab bar view
              Expanded(
                child: TabBarView(children: tabBarViews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Chat chat = Chat(
  id: 5,
  title: 'dumaem',
  logo: NetworkImage(
    'https://womanel.com/wp-content/uploads/2023/05/AD_147011810-2400x1600.jpg',
  ),
  countParticipants: 5,
);

// test data
class Chat {
  int id;
  String title;
  ImageProvider logo;
  int countParticipants;

  Chat({
    required this.id,
    required this.title,
    required this.logo,
    required this.countParticipants,
  });
}
