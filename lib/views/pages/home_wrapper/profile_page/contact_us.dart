import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('contact us'),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'If you have any problems regarding the application , please reach out to us at :',
              style: Appstyle().mainText,
              textAlign: TextAlign.justify,
            ),
            Text(
              'shared_commute@gmail.com',
              style: Appstyle().titleText.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.center,
            ),
            Text(
              'Best Regards: Team Shared Commute',
              style: Appstyle().mainText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
