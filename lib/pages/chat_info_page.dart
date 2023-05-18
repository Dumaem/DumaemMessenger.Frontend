import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/properties/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../generated/l10n.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';
import '../properties/chat_page_arguments.dart';
import '../server/chat/chat_service.dart';
import '../server/user/user_service.dart';
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
  late final String? arguments;

  late List<Widget> tabBarViews;
  late List<Widget> tabs;

  //late final ChatModel currentChat;
  late String _chatGuidName;
  final _chatService = ChatService();
  Future<ChatModel>? _getChatModel;

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

    tabBarViews = [
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
    _chatGuidName =
        (ModalRoute.of(context)!.settings.arguments as ScreenArguments).chatGuid
            as String;
    _getChatModel = _chatService.getChatView(_chatGuidName);

    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, '/home');
        return true;
      },
      child: FutureBuilder<ChatModel>(
        future: _getChatModel,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
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
                                            style: TextStyle(
                                                fontSize: smallFontSize),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value ==
                                            S.of(context).add_member_title) {}
                                      },
                                    ),
                                  ))),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: bigChatCircleAvatarRadius,
                              child: Text(
                                  snapshot.data!.groupName[0].toUpperCase()),
                            ),

                            const Margin20(),

                            // chat name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.groupName,
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
                              "${snapshot.data!.groupName} ${S.of(context).participants_title.toLowerCase()}",
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
        },
      ),
    );
  }
}
