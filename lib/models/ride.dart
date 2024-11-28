import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  String? uid;
  bool? active;
  bool? resolved;
  Timestamp? creationTime;
  Timestamp? resolutionTime;
  String? user1;
  String? user1Origin;
  String? user1Dest;
  String? user2;
  String? user2Origin;
  String? user2Dest;

  Ride(
      {this.uid,
      this.active,
      this.resolved,
      this.creationTime,
      this.resolutionTime,
      this.user1,
      this.user1Origin,
      this.user1Dest,
      this.user2,
      this.user2Origin,
      this.user2Dest});

  Ride.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    active = json['active'];
    resolved = json['resolved'];
    creationTime = json['creation_time'];
    resolutionTime = json['resolution_time'];
    user1 = json['user1'];
    user1Origin = json['user1_origin'];
    user1Dest = json['user1_dest'];
    user2 = json['user2'];
    user2Origin = json['user2_origin'];
    user2Dest = json['user2_dest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['active'] = active;
    data['resolved'] = resolved;
    data['creation_time'] = creationTime;
    data['resolution_time'] = resolutionTime;
    data['user1'] = user1;
    data['user1_origin'] = user1Origin;
    data['user1_dest'] = user1Dest;
    data['user2'] = user2;
    data['user2_origin'] = user2Origin;
    data['user2_dest'] = user2Dest;
    return data;
  }
}

class RideLog {
  String? uid;
  Timestamp? timestamp;
  bool? active;

  RideLog({this.uid, this.timestamp, this.active});

  RideLog.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    timestamp = json['timestamp'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['timestamp'] = timestamp;
    data['active'] = active;
    return data;
  }
}
