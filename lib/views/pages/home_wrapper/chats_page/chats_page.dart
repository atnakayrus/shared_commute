import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('chats'),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
