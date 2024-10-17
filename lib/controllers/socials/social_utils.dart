import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_commute/models/user_model.dart';

class SocialUtils {
  static final firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUserListByEmail(String email) async {
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    // Check if any documents were returned
    if (querySnapshot.docs.isNotEmpty) {
      List<UserModel> users = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(data);
        if ((user.email ?? '').contains(email)) {
          users.add(user);
        }
      }
      return users;
    } else {
      return [];
    }
  }

  Future<UserModel> getUserById(String uid) async {
    final snapshot = await firestore.collection('users').doc(uid).get();
    UserModel user =
        UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return user;
  }
}
