import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_commute/consts/enums.dart';
import 'package:shared_commute/models/chat_room.dart';
import 'package:shared_commute/models/message.dart';

class MessageController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ResponseCode> sendMessage(
      {required Message message, required String roomId}) async {
    try {
      firestore
          .collection('chats')
          .doc(roomId)
          .collection('message')
          .add(message.toJson());
      firestore.collection('chats').doc(roomId).update({
        "last_updated": Timestamp.now().toString(),
      });
      return ResponseCode.success;
    } catch (e) {
      return ResponseCode.serverError;
    }
  }

  Future<List<Message>?> getMessages({required String roomId}) async {
    try {
      QuerySnapshot doc = await firestore
          .collection('chats')
          .doc(roomId)
          .collection('message')
          .get();
      print(doc.docs);
      DocumentSnapshot docs =
          await firestore.collection('chats').doc(roomId).get();
      print(docs.data());
      ChatRoom chatRoom = ChatRoom();
      return chatRoom.messages;
    } catch (e) {
      return null;
    }
  }

  Stream<QuerySnapshot> getStream({required String roomId}) {
    return firestore
        .collection('chats')
        .doc(roomId)
        .collection('message')
        .snapshots();
  }
}
