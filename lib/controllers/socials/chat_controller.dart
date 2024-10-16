import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_commute/consts/enums.dart';
import 'package:shared_commute/models/chat_room.dart';
import 'package:shared_commute/models/user_model.dart';

class ChatController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> hasChats(String uid) async {
    DocumentSnapshot doc =
        await firestore.collection('chatRooms').doc(uid).get();
    if (doc.exists) {
      return true;
    } else {
      firestore.collection('chatRooms').doc(uid).set({"uid": uid});
      return (false);
    }
  }

  Future<ChatRoom> getChat(String uid) async {
    DocumentSnapshot doc = await firestore.collection('chats').doc(uid).get();
    ChatRoom chats = ChatRoom.fromJson(doc.data() as Map<String, dynamic>);
    return chats;
  }

  Stream<QuerySnapshot> getChatStream(String uid) {
    return firestore
        .collection('chatRooms')
        .doc(uid)
        .collection('rooms')
        .orderBy("last_updated", descending: true)
        .snapshots();
  }

  Future<ResponseCode> createChatRoom(User user1, UserModel user2) async {
    try {
      List<String> ls = [user1.uid, user2.uid!];
      ls.sort();
      String roomId = ls[0] + ls[1];
      bool exists = await roomExists(roomId: roomId);
      if (exists) {
        return ResponseCode.success;
      } else {
        ChatRoom room = ChatRoom(
          uid: roomId,
          person1: user1.uid,
          person2: user2.uid,
          person1Name: user1.displayName,
          person2Name: user2.displayName,
          lastUpdated: Timestamp.now(),
          messages: [],
        );
        firestore.collection('chats').doc(roomId).set(room.toJson());
        firestore
            .collection('chatRooms')
            .doc(user1.uid)
            .collection('rooms')
            .doc(roomId)
            .set({'roomId': roomId, "last_updated": Timestamp.now()});
        firestore
            .collection('chatRooms')
            .doc(user2.uid)
            .collection('rooms')
            .doc(roomId)
            .set({'roomId': roomId, "last_updated": Timestamp.now()});
        return ResponseCode.success;
      }
    } catch (e) {
      return ResponseCode.serverError;
    }
  }

  Future<bool> roomExists({required String roomId}) async {
    DocumentSnapshot doc =
        await firestore.collection('chats').doc(roomId).get();
    return doc.exists;
  }
}
