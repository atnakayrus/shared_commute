class ChatHeads {
  String? uid;
  List<String>? rooms;

  ChatHeads({this.uid, this.rooms});

  ChatHeads.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    rooms = json['rooms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['rooms'] = rooms;
    return data;
  }
}
