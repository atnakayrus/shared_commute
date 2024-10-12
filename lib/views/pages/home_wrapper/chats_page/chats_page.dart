import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/widgets/chat_tile.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController searchController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
              ChatTile(),
            ],
          ),
        ));
  }
}
