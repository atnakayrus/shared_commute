import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class EditProfile extends StatefulWidget {
  static const pageId = '/editProfile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('Edit Profile'),
    );
  }
}
