import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? email;
  final String? fullname;
  final String? username;

  User({this.email, this.fullname, this.username});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        email: doc['email'],
        fullname: doc['fullname'],
        username: doc['username']);
  }
}
