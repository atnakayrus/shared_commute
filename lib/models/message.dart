import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? text;
  Timestamp? timestamp;
  String? sender;

  Message({this.text, this.timestamp, this.sender});

  Message.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    timestamp = json['timestamp'];
    sender = json['sender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = text;
    data['timestamp'] = timestamp;
    data['sender'] = sender;
    return data;
  }
}
