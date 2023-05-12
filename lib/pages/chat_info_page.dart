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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // chat details
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // count participants
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          '5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Participants',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    // chat logo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[300]),
                      ),
                    ),

                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '1.1k',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Followers',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 20),

                // chat name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'dumaem',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // edit chat
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('Edit chat'),
                          ),
                        ),
                      ),

                      const SizedBox(width: 20),

                      // contact
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('Add participants',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // tab bar
                TabBar(tabs: tabs),

                //tab bar view
                Expanded(child: TabBarView(children: tabBarViews)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
