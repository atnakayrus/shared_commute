import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

PreferredSizeWidget? scAppBar(String title) {
  return AppBar(
    title: Text(
      _titleConverter(title),
      style: Appstyle().mainText,
    ),
    centerTitle: true,
  );
}

String _titleConverter(String title) {
  String res = '';
  for (int i = 0; i < title.length; i++) {
    res = "$res${title[i].toUpperCase()} ";
  }
  res.substring(res.length - 1);
  return (res);
}
