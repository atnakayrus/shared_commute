import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_commute/views/pages/login_signup_routes/login_page.dart';

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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
      ),
      home: LoginPage(),
    );
  }
}
