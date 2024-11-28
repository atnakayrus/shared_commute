import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_commute/models/message.dart';

class ChatRoom {
  String? uid;
  String? person1;
  String? person1Name;
  String? person2;
  String? person2Name;
  Timestamp? lastUpdated;
  String? lastMessage;
  String? lastMessageSender;
  bool? lastMessageViewed;
  List<Message>? messages;

  ChatRoom(
      {this.uid,
      this.person1,
      this.person1Name,
      this.person2,
      this.person2Name,
      this.lastUpdated,
      this.lastMessage,
      this.lastMessageSender,
      this.lastMessageViewed,
      this.messages});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    person1 = json['person1'];
    person2 = json['person2'];
    lastUpdated = json['last_updated'];
    lastMessage = json['last_message'];
    lastMessageSender = json['last_message_sender'];
    lastMessageViewed = json['last_message_viewed'];
    person1Name = json['person1Name'];
    person2Name = json['person2Name'];
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['person1'] = person1;
    data['person2'] = person2;
    data['person1Name'] = person1Name;
    data['person2Name'] = person2Name;
    data['last_updated'] = lastUpdated;
    data['last_message'] = lastMessage;
    data['last_message_sender'] = lastMessageSender;
    data['last_message_viewed'] = lastMessageViewed;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
