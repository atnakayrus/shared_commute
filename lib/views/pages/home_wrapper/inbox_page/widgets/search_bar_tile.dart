import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/inbox_page/search_page.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';
import 'package:shared_commute/views/widgets/sc_search_bar.dart';

class SearchTile extends StatelessWidget {
  SearchTile({super.key, required this.controller});

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          ScIconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.pageId);
            },
            icon: Icons.person_add,
            isOutlined: true,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ScSearchBar(controller: controller),
          ),
        ],
      ),
    );
  }
}
