import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/models/google_route.dart';

class HomeBottomTab extends StatelessWidget {
  final GoogleRoute gRoute;
  final Function() onTap;
  const HomeBottomTab({super.key, required this.gRoute, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.25,
      maxChildSize: 0.5,
      initialChildSize: 0.25,
      builder: (context, scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: onTap,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              margin: const EdgeInsets.all(15),
                              child: Text(
                                'Search Nearby',
                                style: Appstyle().buttonText,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Distance:",
                                style: Appstyle().mainText,
                              ),
                              Text(
                                gRoute.distance!.text!,
                                style: Appstyle().mainText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Estimated time:",
                                style: Appstyle().mainText,
                              ),
                              Text(
                                gRoute.duration!.text!,
                                style: Appstyle().mainText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
