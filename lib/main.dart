import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_commute/provider/user_provider.dart';
import 'package:shared_commute/views/pages/home_wrapper/inbox_page/add_new_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/inbox_page/search_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_commute/views/pages/home_wrapper/auth_load_page.dart';
import 'package:shared_commute/views/pages/home_wrapper/profile_page/edit_profile.dart';
import 'package:shared_commute/views/pages/login_signup_routes/login_page.dart';
import 'package:shared_commute/views/pages/login_signup_routes/signup_page.dart';
import 'package:shared_commute/views/pages/new_rides/new_ride_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfigPlus.loadEnvVariables();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
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
        '/editProfile': (context) => const EditProfile(),
        '/newRide': (context) => const NewRidePage(),
      },
      initialRoute: '/',
      navigatorObservers: [routeObserver],
    );
  }
}
