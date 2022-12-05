import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/app/models/user.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? usermodel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (docSnap.data() != null) {
      usermodel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return usermodel;
  }
}
