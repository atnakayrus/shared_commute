import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/add_new_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/chat_page/chat_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/search_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_commute/views/pages/home_wrapper/auth_load_page.dart';
import 'package:shared_commute/views/pages/login_signup_routes/login_page.dart';
import 'package:shared_commute/views/pages/login_signup_routes/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
      ),
      routes: {
        '/': (context) => const AuthLoadPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomeWrapper(),
        '/searchPage': (context) => const SearchPage(),
        '/addNewPage': (context) => const AddNewPage(),
      },
      initialRoute: '/',
    );
  }
}
