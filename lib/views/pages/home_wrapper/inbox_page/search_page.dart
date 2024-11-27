import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/sc_search_bar.dart';

class SearchPage extends StatefulWidget {
  static const pageId = '/searchPage';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: '');
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: ScSearchBar(controller: searchController)),
          ],
        ),
      ),
    );
  }
}
