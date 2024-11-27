import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/socials/social_utils.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/views/pages/home_wrapper/inbox_page/widgets/searched_user_tile.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';

class AddNewPage extends StatefulWidget {
  static const pageId = '/addNewPage';
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  TextEditingController searchController = TextEditingController(text: '');
  List<UserModel> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(hintText: 'Search by email id'),
          controller: searchController,
          autofocus: true,
          style: Appstyle().subtitleText,
        ),
        actions: [
          ScIconButton(
            onPressed: () async {
              List<UserModel> matchedUsers =
                  await SocialUtils().getUserListByEmail(searchController.text);
              for (UserModel user in List.from(matchedUsers)) {
                if (user.email == UserAuthController().getUser!.email) {
                  matchedUsers.remove(user);
                }
              }

              setState(() {
                users = matchedUsers;
              });
            },
            icon: Icons.search,
            isOutlined: false,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: users.map((user) {
            return SearchedUserTile(user: user);
          }).toList(),
        ),
      ),
    );
  }
}
