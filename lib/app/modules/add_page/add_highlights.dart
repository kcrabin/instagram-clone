import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/authentication/register/register.dart';
import 'package:uuid/uuid.dart';

// final StorageRefrence storageRef = FirebaseFirestore.instance.ref();
final storyRef = FirebaseFirestore.instance.collection('highlights');

final DateTime timestamp = DateTime.now();

final _auth = FirebaseAuth.instance;

class AddHighlightsPage extends StatefulWidget {
  final String imageUrl;

  AddHighlightsPage({super.key, required this.imageUrl});

  @override
  State<AddHighlightsPage> createState() => _AddHighlightsPageState();
}

class _AddHighlightsPageState extends State<AddHighlightsPage> {
  String storyId = Uuid().v4();

  bool isUplaoding = false;
  String? username;
  String? storyOwnerProfile;

  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;
      // String uid = "fztP1FFujAAWLZi8IHKa";

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        // print(doc['username'] ?? '');
        username = doc['username'];
        storyOwnerProfile = doc['profilepic'];

        // print(uid);
        // print(doc.data());
        print(username);
      });
    } catch (e) {
      print(e);
    }
  }

  handleSubmit() {
    String imagePath = widget.imageUrl;

    setState(() {
      isUplaoding = true;
    });

    storyRef.doc().set({
      "highlights_id": storyId,
      "email": _auth.currentUser!.email,
      "imagepath": imagePath,
      "username": username,
      "highlightsOwnerProfile": storyOwnerProfile,
      "time": timestamp,
    });
    setState(() {
      isUplaoding = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 35,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'New highlights',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        //  Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: isUplaoding ? null : () => handleSubmit(),
              child: Icon(
                Icons.check,
                size: 35,
                color: Colors.blue[400],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              isUplaoding ? LinearProgressIndicator() : Text(''),
              Container(
                color: Colors.grey,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
