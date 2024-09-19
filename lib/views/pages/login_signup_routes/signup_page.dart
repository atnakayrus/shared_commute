import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/user_auth/user_controller.dart';
import 'package:shared_commute/views/widgets/sc_button.dart';
import 'package:shared_commute/views/widgets/sc_text_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController displayNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController pNoController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
              width: double.infinity,
            ),
            Text(
              'SIGNUP',
              style: Appstyle().headerText,
            ),
            const SizedBox(
              height: 20,
            ),
            ScTextInput.halfWidth(
              controller: emailController,
              labelText: "Email id",
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: displayNameController,
              labelText: "Your name",
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: pNoController,
              labelText: "Phone number",
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: dobController,
              labelText: "Date of Birth",
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: passwordController,
              isPassword: true,
              labelText: "Enter Password",
            ),
            const SizedBox(
              height: 10,
            ),
            ScTextInput.halfWidth(
              controller: confirmPasswordController,
              isPassword: true,
              labelText: "Confirm Password",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Have an account ? ',
                  style: Appstyle().helperText,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: Text(
                    'Login instead',
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
                UserController()
                    .userSignup(emailController.text, passwordController.text);
              },
              text: "SIGNUP",
            ),
          ],
        ),
      ),
    );
  }
}
