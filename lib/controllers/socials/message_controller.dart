import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_commute/consts/enums.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/models/message.dart';

class MessageController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ResponseCode> sendMessage(
      {required Message message,
      required String roomId,
      required String receiever}) async {
    try {
      firestore
          .collection('chats')
          .doc(roomId)
          .collection('message')
          .add(message.toJson());
      firestore.collection('chats').doc(roomId).update({
        "last_updated": Timestamp.now(),
        "last_message": message.text,
        "last_message_sender": UserAuthController().getUser!.uid,
        "last_message_viewed": false,
      });
      firestore
          .collection('chatRooms')
          .doc(message.sender)
          .collection('rooms')
          .doc(roomId)
          .update({"last_updated": Timestamp.now()});
      firestore
          .collection('chatRooms')
          .doc(receiever)
          .collection('rooms')
          .doc(roomId)
          .update({"last_updated": Timestamp.now()});
      return ResponseCode.success;
    } catch (e) {
      return ResponseCode.serverError;
    }
  }

  void markChatAsRead(String roomId) async {
    final doc = await firestore.collection('chats').doc(roomId).get();
    final data = doc.data() as Map<String, dynamic>;
    if (data['last_message_sender'] != UserAuthController().getUser!.uid) {
      firestore.collection('chats').doc(roomId).update({
        "last_message_viewed": true,
      });
    }
  }

  Stream<QuerySnapshot> getStream({required String roomId}) {
    return firestore
        .collection('chats')
        .doc(roomId)
        .collection('message')
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
