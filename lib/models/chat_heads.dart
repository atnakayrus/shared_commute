class ChatHeads {
  String? uid;
  List<String>? rooms;

  ChatHeads({this.uid, this.rooms});

  ChatHeads.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    rooms = json['rooms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['rooms'] = this.rooms;
    return data;
  }
}
