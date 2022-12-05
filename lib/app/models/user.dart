import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? fullname;
  String? username;
  String? profilepic;
  String? uid;

  UserModel(
      {this.email, this.fullname, this.username, this.profilepic, this.uid});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      email: doc['email'],
      fullname: doc['fullname'],
      username: doc['username'],
      profilepic: doc['profilepic'],
      uid: doc['uid'],
    );
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    fullname = map['fullname'];
    username = map['username'];
    profilepic = map['profilepic'];
    uid = map['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullname': fullname,
      'username': username,
      'profilepic': profilepic,
      'uid': uid,
    };
  }
}
