class ChatRoom {
  String? uid;
  String? person1;
  String? person2;
  String? lastUpdated;
  String? lastMessage;
  String? lastMessageSender;
  bool? lastMessageViewed;

  ChatRoom(
      {this.uid,
      this.person1,
      this.person2,
      this.lastUpdated,
      this.lastMessage,
      this.lastMessageSender,
      this.lastMessageViewed});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    person1 = json['person1'];
    person2 = json['person2'];
    lastUpdated = json['last_updated'];
    lastMessage = json['last_message'];
    lastMessageSender = json['last_message_sender'];
    lastMessageViewed = json['last_message_viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['person1'] = person1;
    data['person2'] = person2;
    data['last_updated'] = lastUpdated;
    data['last_message'] = lastMessage;
    data['last_message_sender'] = lastMessageSender;
    data['last_message_viewed'] = lastMessageViewed;
    return data;
  }
}
