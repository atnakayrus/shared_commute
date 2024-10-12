import 'package:flutter/material.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/views/widgets/sc_button.dart';
import 'package:shared_commute/views/widgets/sc_text_input.dart';

class SignupPage extends StatefulWidget {
  static const pageId = '/signup';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            // height: 150,
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
            labelText: "Email id *",
          ),
          const SizedBox(
            height: 10,
          ),
          ScTextInput.halfWidth(
            controller: displayNameController,
            labelText: "Your name *",
          ),
          const SizedBox(
            height: 10,
          ),
          ScTextInput.halfWidth(
            controller: passwordController,
            isPassword: true,
            labelText: "Enter Password *",
          ),
          const SizedBox(
            height: 10,
          ),
          ScTextInput.halfWidth(
            controller: confirmPasswordController,
            isPassword: true,
            labelText: "Confirm Password *",
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
            onTap: () async {
              if (emailController.text != '' &&
                  displayNameController.text != '' &&
                  passwordController.text != '' &&
                  confirmPasswordController.text == passwordController.text) {
                if (!emailController.text.contains('jnu.ac.in')) {
                  showToast('Please enter jnu id');
                } else {
                  int res = await UserAuthController().userSignup(
                    email: emailController.text,
                    password: passwordController.text,
                    displayName: displayNameController.text,
                  );
                  if (res == 1 && context.mounted) {
                    Navigator.popAndPushNamed(context, '/');
                  }
                }
              }
            },
            text: "SIGNUP",
          ),
        ],
      ),
    );
  }
}
