import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/views/widgets/corner_flair.dart';

class RideTile extends StatelessWidget {
  const RideTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        // height: 200,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Surya Kanta Ghosh',
                              style: Appstyle().subtitleText,
                            ),
                            Text(
                              'surya@1406',
                              style: Appstyle().contentText,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'From',
                        style: Appstyle().contentText,
                      ),
                      Text(
                        'Jnu',
                        style: Appstyle().contentText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To',
                        style: Appstyle().contentText,
                      ),
                      Text(
                        'delhi',
                        style: Appstyle().contentText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '11/09/2001',
                        style: Appstyle().contentText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CornerFlair.topRight(
              size: 50,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
