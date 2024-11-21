import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/profile_page/profile_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/rides_page/rides_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/chats_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_page/home_page.dart';

class HomeWrapper extends StatefulWidget {
  static const pageId = '/home';
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int selected = 0;

  Widget selectedPage(selectedPage) {
    switch (selectedPage) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatsPage();
      case 2:
        return const RidesPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedPage(selected),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black,
          currentIndex: selected,
          onTap: (value) {
            setState(() {
              selected = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pedal_bike),
              label: 'Rides',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
