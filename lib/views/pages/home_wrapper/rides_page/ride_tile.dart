import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/consts/global_consts.dart';
import 'package:shared_commute/controllers/ride_controller/ride_service.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/controllers/user_data/user_data_controller.dart';
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/models/ride.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/services/geocoding_service.dart';
import 'package:shared_commute/views/widgets/corner_flair.dart';

class RideTile extends StatefulWidget {
  final RideLog ride;
  const RideTile({super.key, required this.ride});

  @override
  State<RideTile> createState() => _RideTileState();
}

class _RideTileState extends State<RideTile> {
  UserModel? user2;
  Address? origin;
  Address? destination;
  Ride? ride;
  bool isFirstUser = true;

  @override
  void initState() {
    super.initState();

    getDetails();
  }

  void getDetails() async {
    Ride r = await RideService().getRideById(widget.ride.uid!);
    setState(() {
      if (context.mounted) {
        ride = r;
      }
      if (ride!.user2 == UserAuthController().getUser!.uid) {
        isFirstUser = false;
      }
    });
    if (!isFirstUser) {
      UserDataController().getUserById(ride!.user1!).then((UserModel user) {
        if (context.mounted) {
          setState(() {
            user2 = user;
          });
        }
      });
    } else if (ride!.user2 != null) {
      UserDataController().getUserById(ride!.user2!).then((UserModel user) {
        if (context.mounted) {
          setState(() {
            user2 = user;
          });
        }
      });
    }
    GeocodingService()
        .getAddressByPlaceId(
            isFirstUser ? ride!.user1Origin! : ride!.user2Origin!)
        .then((Address add) {
      if (context.mounted) {
        setState(() {
          origin = add;
        });
      }
    });
    GeocodingService()
        .getAddressByPlaceId(isFirstUser ? ride!.user1Dest! : ride!.user2Dest!)
        .then((Address add) {
      if (context.mounted) {
        setState(() {
          destination = add;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ride == null
          ? Text(
              'Please Wait',
              style: Appstyle().mainText,
            )
          : Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ride!.user2 == null
                            ? widget.ride.active ?? false
                                ? Text(
                                    'Waiting for a match',
                                    style: Appstyle().mainText,
                                  )
                                : Text(
                                    'Trip Failed',
                                    style: Appstyle().mainText,
                                  )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(user2 == null
                                        ? GlobalConsts.altPfp
                                        : user2!.displayPic ??
                                            GlobalConsts.altPfp),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user2 == null
                                              ? '-------------'
                                              : user2!.displayName!,
                                          style: Appstyle().subtitleText,
                                          softWrap: true,
                                        ),
                                        Text(
                                          user2 == null
                                              ? '-------------'
                                              : user2!.email!,
                                          style: Appstyle().contentText,
                                          softWrap: true,
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
                            SizedBox(
                              width: 80,
                              child: Text(
                                'From',
                                style: Appstyle().contentText,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                origin == null
                                    ? "----------"
                                    : origin!.formattedAddress!,
                                style: Appstyle().contentText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                'To',
                                style: Appstyle().contentText,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                destination == null
                                    ? "----------"
                                    : destination!.formattedAddress!,
                                style: Appstyle().contentText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                              ride == null
                                  ? '---------'
                                  : "${ride!.creationTime!.toDate().hour % 12} : ${ride!.creationTime!.toDate().minute} ${ride!.creationTime!.toDate().hour > 12 ? 'pm' : 'am'}",
                              style: Appstyle().contentText,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ride == null
                                  ? '---------'
                                  : "${ride!.creationTime!.toDate().day} / ${ride!.creationTime!.toDate().month} / ${ride!.creationTime!.toDate().year}",
                              style: Appstyle().contentText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (ride != null)
                    CornerFlair.topRight(
                      size: 50,
                      color: ride!.active!
                          ? Colors.yellow
                          : ride!.resolved ?? true
                              ? Colors.green
                              : Colors.red,
                    ),
                ],
              ),
            ),
    );
  }
}
