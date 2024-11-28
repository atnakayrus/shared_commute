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
import 'package:shared_commute/views/pages/home_wrapper/inbox_page/chat_page/chat_page.dart';

class NearbyTile extends StatefulWidget {
  final Ride ride;
  const NearbyTile({super.key, required this.ride});

  @override
  State<NearbyTile> createState() => _NearbyTileState();
}

class _NearbyTileState extends State<NearbyTile> {
  UserModel? user;
  UserModel? self;
  Address? origin;
  Address? dest;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    UserModel u = await UserDataController().getUserById(widget.ride.user1!);
    UserModel s = await UserDataController()
        .getUserById(UserAuthController().getUser!.uid);
    Address o =
        await GeocodingService().getAddressByPlaceId(widget.ride.user1Origin!);
    Address d =
        await GeocodingService().getAddressByPlaceId(widget.ride.user1Dest!);
    setState(() {
      user = u;
      origin = o;
      dest = d;
      self = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user == null
                    ? GlobalConsts.altPfp
                    : user!.displayPic ?? GlobalConsts.altPfp),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user == null ? "----------" : user!.displayName!,
                      style: Appstyle().subtitleText,
                    ),
                    Text(
                      user == null ? "----------" : user!.email!,
                      style: Appstyle().contentText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'Is Going From :',
            style: Appstyle().helperText,
          ),
          Text(
            origin == null ? "----------" : origin!.formattedAddress!,
            style: Appstyle().contentText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'To :',
            style: Appstyle().helperText,
          ),
          Text(
            dest == null ? "----------" : dest!.formattedAddress!,
            style: Appstyle().contentText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () async {
              if (self == null) {
                return;
              }
              await RideService().concludeRide(
                  rideId: widget.ride.uid!,
                  newOriginId: origin!.placeId!,
                  newDestId: dest!.placeId!);
              print(widget.ride.uid!);
              await RideService().sendRideMessage(self!, user!);
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(user: user!)));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Text(
                'Select this ride',
                style: Appstyle().buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
