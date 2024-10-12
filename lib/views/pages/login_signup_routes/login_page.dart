import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/views/widgets/sc_button.dart';
import 'package:shared_commute/views/widgets/sc_text_input.dart';

class LoginPage extends StatefulWidget {
  static const pageId = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: Appstyle().headerText,
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: emailController,
              hintText: "Email id",
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: passwordController,
              isPassword: true,
              hintText: "Password",
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'New User ? ',
                  style: Appstyle().helperText,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/signup');
                  },
                  child: Text(
                    'Signup instead',
                    style: Appstyle()
                        .helperText
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ScButton(
              onTap: () {
                UserAuthController()
                    .userLogin(emailController.text, passwordController.text);
              },
              text: "LOGIN",
            )
          ],
        ),
      ),
    );
  }
}
