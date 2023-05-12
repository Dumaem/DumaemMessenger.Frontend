import 'package:flutter/material.dart';

import '../tabs/chat_participants_view.dart';
import '../tabs/photos_view.dart';
import '../tabs/videos_view.dart';

class ChatInfoPage extends StatefulWidget {
  const ChatInfoPage({Key? key}) : super(key: key);

  @override
  State<ChatInfoPage> createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {
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
      length: 3,
      child: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 190, 233, 244),
          child: Column(
            children:
            [
              Column(
                children: [
                  const SizedBox(height: 40),

                  // appbar with logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://womanel.com/wp-content/uploads/2023/05/AD_147011810-2400x1600.jpg',
                            ),
                            radius: 50,
                          ),
                        ),

                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/home');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // chat name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'dumaem',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // chat name
                  const Text(
                    '5 participants',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),

                  const SizedBox(height: 10),
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
