import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/socials/chat_controller.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/models/chat_room.dart';
import 'package:shared_commute/views/pages/home_wrapper/inbox_page/widgets/chat_tile.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';
import 'package:shared_commute/views/widgets/sc_info_widget.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<InboxPage> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          '  I N B O X',
          style: Appstyle().mainText,
        ),
        centerTitle: false,
        actions: [
          ScIconButton(
            onPressed: () {},
            icon: Icons.search,
            isOutlined: false,
          ),
          ScIconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addNewPage');
            },
            icon: Icons.person_add,
            isOutlined: false,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
          stream:
              ChatController().getChatStream(UserAuthController().getUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Text('Connecting...');
            }
            if (snapshot.data!.docs.isEmpty) {
              return const ScInfoWidget(
                  icon: Icons.message, text: 'Your chats will appear here');
            }
            return ListView(
              children: [
                ...snapshot.data!.docs.map((element) {
                  final data = element.data() as Map<String, dynamic>;
                  return FutureBuilder(
                      future: ChatController().getChat(data['roomId']),
                      initialData: ChatRoom(
                          person1: "",
                          person1Name: "",
                          person2: "",
                          person2Name: ""),
                      builder: (context, snap) {
                        return ChatTile(chat: snap.data!);
                      });
                })
              ],
            );
          }),
    );
  }
}
