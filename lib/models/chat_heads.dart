class ChatHeads {
  String? uid;
  List<Rooms>? rooms;

  ChatHeads({this.uid, this.rooms});

  ChatHeads.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String? roomId;
  String? lastUpdated;

  Rooms({this.roomId, this.lastUpdated});

  Rooms.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roomId'] = roomId;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
