import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScSearchBar extends StatelessWidget {
  final TextEditingController controller;
  const ScSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Appstyle().contentText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        hintText: 'Search',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}
