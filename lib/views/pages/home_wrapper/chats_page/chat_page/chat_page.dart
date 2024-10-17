import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/consts/enums.dart';
import 'package:shared_commute/controllers/socials/chat_controller.dart';
import 'package:shared_commute/controllers/socials/message_controller.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/models/message.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/widgets/message_tile.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';
import 'package:shared_commute/views/widgets/sc_text_box.dart';

class ChatPage extends StatefulWidget {
  static const pageId = '/chatPage';
  final UserModel user;
  final String? roomId;
  const ChatPage({super.key, required this.user, this.roomId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController chat = ChatController();
  MessageController message = MessageController();
  late String roomId;
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    if (widget.roomId == null) {
      List<String> ls = [UserAuthController().getUser!.uid, widget.user.uid!];
      ls.sort();
      roomId = ls[0] + ls[1];
    } else {
      roomId = widget.roomId!;
    }
    MessageController().markChatAsRead(roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.displayName ?? "Display Name",
              style: Appstyle().mainText,
            ),
            Text(
              widget.user.email!,
              style: Appstyle().helperText,
            )
          ],
        ),
        actions: [ScIconButton(onPressed: () {}, icon: Icons.more_vert)],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: ScTextBox(
                controller: messageController,
                onSubmit: () async {
                  if (messageController.text == '') {
                  } else {
                    final code = await chat.createChatRoom(
                        UserAuthController().getUser!, widget.user);
                    if (code == ResponseCode.success) {
                      message.sendMessage(
                          message: Message(
                              text: messageController.text,
                              timestamp: Timestamp.now(),
                              sender: UserAuthController().getUser!.uid),
                          roomId: roomId,
                          receiever: widget.user.uid!);
                      messageController.text = '';
                    }
                  }
                }),
          ),
          Expanded(
            child: StreamBuilder(
                stream: message.getStream(roomId: roomId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return const Text('Connecting...');
                  }
                  return ListView(
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      ...snapshot.data!.docs.map((element) {
                        Message me = Message.fromJson(
                            element.data() as Map<String, dynamic>);
                        return MessageTile(
                            message: me,
                            sender: widget.user.displayName!,
                            self: me.sender != widget.user.uid);
                      }),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
