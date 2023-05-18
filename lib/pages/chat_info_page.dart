import 'package:dumaem_messenger/properties/config.dart';
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
  late List<Widget> tabBarViews;
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    tabs = [
      // chat participants tab
      const Tab(
        icon: Icon(Icons.supervised_user_circle_rounded),
        text: 'participants',
      ),

      // на будущее

      /*// photos tab
      Tab(
        icon: Icon(Icons.image),
      ),
      // videos tab
      Tab(
        icon: Icon(Icons.video_collection_rounded),
      ),*/
    ];

    tabBarViews = const [
      // chat participants view
      ChatParticipantsView(),

      // на будущее

      /*// photos view
      PhotosView(),
      // videos view
      VideosView(),*/
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                pinned: true,
                floating: true,
                actions: [
                  // settings button
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: bigChatCircleAvatarRadius,
                      child: Text(chat.title![0].toUpperCase()),
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
                      "${currentChat.countParticipants} ${S.of(context).participants_title.toLowerCase()}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: tabBarViews),
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
