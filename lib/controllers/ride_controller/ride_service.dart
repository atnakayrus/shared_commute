import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_commute/consts/enums.dart';
import 'package:shared_commute/controllers/socials/chat_controller.dart';
import 'package:shared_commute/controllers/socials/message_controller.dart';
import 'package:shared_commute/controllers/user_data/user_data_controller.dart';
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/models/google_route.dart';
import 'package:shared_commute/models/message.dart';
import 'package:shared_commute/models/ride.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/services/geocoding_service.dart';

class RideService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final firestore = FirebaseFirestore.instance;

  void updateRideStatus() async {
    final docs = await firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('rides')
        .where('active', isEqualTo: true)
        .get();
    for (QueryDocumentSnapshot doc in docs.docs) {
      RideLog rideLog = RideLog.fromJson(doc.data() as Map<String, dynamic>);
      Ride ride = await getRideById(rideLog.uid!);
      DateTime now = DateTime.now();
      DateTime creationTime = ride.rideStartTime == null
          ? ride.creationTime!.toDate()
          : ride.rideStartTime!.toDate();
      Duration diff = now.difference(creationTime);
      if (diff.inMinutes > 20) {
        firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('rides')
            .doc(doc.id)
            .update(
          {'active': false},
        );
        firestore
            .collection('rides')
            .doc(rideLog.uid!)
            .update({'active': false, 'resolved': false});
      }
    }
  }

  Future<List<Ride>> getNearbyRides(
      {required Address origin,
      required Address dest,
      required DateTime selectedTime}) async {
    List<Ride> validRides = [];
    await firestore
        .collection('rides')
        .where('active', isEqualTo: true)
        .get()
        .then((querySnapshot) async {
      List<Future<Ride?>> futures = querySnapshot.docs
          .map((doc) => _isRideValid(
              origin: origin,
              dest: dest,
              newRide: Ride.fromJson(doc.data()),
              selectedTime: selectedTime))
          .toList();

      List<Ride?> result = await Future.wait(futures);
      for (final res in result) {
        if (res != null) {
          validRides.add(res);
        }
      }
    });
    return validRides;
  }

  Future<Ride?> _isRideValid(
      {required Address origin,
      required Address dest,
      required Ride newRide,
      required DateTime selectedTime}) async {
    if (newRide.user1 == _auth.currentUser!.uid) {
      return null;
    } else {
      DateTime rideStartTime = newRide.rideStartTime!.toDate();
      Duration diff = selectedTime.difference(rideStartTime);
      if (diff.inMinutes > 15 || diff.inMinutes < 30) {
        return null;
      }

      Address origin2 =
          await GeocodingService().getAddressByPlaceId(newRide.user1Origin!);
      Address dest2 =
          await GeocodingService().getAddressByPlaceId(newRide.user1Dest!);
      GoogleRoute dist = await GeocodingService().getPathDistance(
          LatLng(
              origin.geometry!.location!.lat!, origin.geometry!.location!.lng!),
          LatLng(origin2.geometry!.location!.lat!,
              origin2.geometry!.location!.lng!));
      if (dist.distance!.value! < 150) {
        GoogleRoute originalRoute = await GeocodingService().getPathDistance(
            LatLng(origin.geometry!.location!.lat!,
                origin.geometry!.location!.lng!),
            LatLng(
                dest.geometry!.location!.lat!, dest.geometry!.location!.lng!));

        GoogleRoute brokenRoute1 = await GeocodingService().getPathDistance(
            LatLng(origin.geometry!.location!.lat!,
                origin.geometry!.location!.lng!),
            LatLng(dest2.geometry!.location!.lat!,
                dest2.geometry!.location!.lng!));

        GoogleRoute brokenRoute2 = await GeocodingService().getPathDistance(
            LatLng(
                dest2.geometry!.location!.lat!, dest2.geometry!.location!.lng!),
            LatLng(
                dest.geometry!.location!.lat!, dest.geometry!.location!.lng!));

        GoogleRoute originalAltRoute = await GeocodingService().getPathDistance(
            LatLng(origin2.geometry!.location!.lat!,
                origin2.geometry!.location!.lng!),
            LatLng(dest2.geometry!.location!.lat!,
                dest2.geometry!.location!.lng!));

        GoogleRoute brokenAltRoute1 = await GeocodingService().getPathDistance(
            LatLng(origin2.geometry!.location!.lat!,
                origin2.geometry!.location!.lng!),
            LatLng(
                dest.geometry!.location!.lat!, dest.geometry!.location!.lng!));

        GoogleRoute brokenAltRoute2 = await GeocodingService().getPathDistance(
            LatLng(
                dest.geometry!.location!.lat!, dest.geometry!.location!.lng!),
            LatLng(dest2.geometry!.location!.lat!,
                dest2.geometry!.location!.lng!));

        double distRatio =
            (brokenRoute1.distance!.value! + brokenRoute2.distance!.value!) /
                originalRoute.distance!.value!;

        double distAltRatio = (brokenAltRoute1.distance!.value! +
                brokenAltRoute2.distance!.value!) /
            originalAltRoute.distance!.value!;
        if (distRatio < 1.25 || distAltRatio < 1.25) {
          return newRide;
        } else {
          return null;
        }
      }
    }
    return null;
  }

  Future<Ride> getRideById(String id) async {
    final doc = await firestore.collection('rides').doc(id).get();
    Ride ride = Ride.fromJson(doc.data() as Map<String, dynamic>);
    return ride;
  }

  Stream<QuerySnapshot> getRidesStream() {
    return firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('rides')
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<bool> hasActiveRide() async {
    final rides = await firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('rides')
        .where('active', isEqualTo: true)
        .get();
    if (rides.size != 0) {
      return true;
    }
    return false;
  }

  Future<Ride> createRide(
      {required Address origin,
      required Address destination,
      required Timestamp startTime,
      required bool hasVehicle}) async {
    UserModel user =
        await UserDataController().getUserById(_auth.currentUser!.uid);
    Timestamp time = Timestamp.now();
    String uid = user.uid! + time.seconds.toString();
    Ride newRide = Ride(
      active: true,
      resolved: false,
      uid: uid,
      user1: user.uid,
      user1Origin: origin.placeId,
      user1Dest: destination.placeId,
      creationTime: Timestamp.now(),
      rideStartTime: startTime,
      vehicleAvailable: hasVehicle,
    );
    await firestore.collection('rides').doc(uid).set(newRide.toJson());
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('rides')
        .add(RideLog(uid: uid, timestamp: time, active: true).toJson());
    return newRide;
  }

  Future<Ride> cancelRide({required String rideId}) async {
    await firestore.collection('rides').doc(rideId).update({"active": false});
    final doc = await firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('rides')
        .where('uid', isEqualTo: rideId)
        .limit(1)
        .get();
    await firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('rides')
        .doc(doc.docs[0].id)
        .update({'active': false, 'resolved': false});
    return Ride();
  }

  Future<Ride> concludeRide(
      {required String rideId,
      required String newOriginId,
      required String newDestId}) async {
    final oldRideData = await firestore.collection('rides').doc(rideId).get();
    Ride oldRide = Ride.fromJson(oldRideData.data() as Map<String, dynamic>);
    await firestore.collection('rides').doc(rideId).update(Ride(
          uid: oldRide.uid,
          active: false,
          resolved: true,
          creationTime: oldRide.creationTime,
          resolutionTime: Timestamp.now(),
          user1: oldRide.user1,
          user1Origin: oldRide.user1Origin,
          user1Dest: oldRide.user1Dest,
          user2: _auth.currentUser!.uid,
          user2Origin: newOriginId,
          user2Dest: newDestId,
        ).toJson());

    final doc1 = await firestore
        .collection('users')
        .doc(oldRide.user1)
        .collection('rides')
        .where('uid', isEqualTo: rideId)
        .limit(1)
        .get();
    await firestore
        .collection('users')
        .doc(oldRide.user1)
        .collection('rides')
        .doc(doc1.docs[0].id)
        .update({'active': false});

    await firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('rides')
        .add({'active': false, 'timestamp': Timestamp.now(), 'uid': rideId});

    final newRideData = await firestore.collection('rides').doc(rideId).get();
    Ride newRide = Ride.fromJson(newRideData.data() as Map<String, dynamic>);
    return newRide;
  }

  Future<ResponseCode> sendRideMessage(UserModel user1, UserModel user2) async {
    try {
      await ChatController().createChatRoom(user1, user2);
      await MessageController().sendMessage(
          message: Message(
              text: 'Hey! I have been matched with you for your ride!',
              timestamp: Timestamp.now(),
              sender: user1.uid),
          roomId: ChatController().createChatRoomId(user1, user2),
          receiever: user2.uid!);
      return ResponseCode.success;
    } catch (e) {
      return ResponseCode.serverError;
    }
  }
}
