import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/authentication/register/register.dart';
import 'package:uuid/uuid.dart';

// final StorageRefrence storageRef = FirebaseFirestore.instance.ref();
final postRef = FirebaseFirestore.instance.collection('post');

final DateTime timestamp = DateTime.now();

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class AddPage extends StatefulWidget {
  final String imageUrl;

  AddPage({super.key, required this.imageUrl});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String postId = Uuid().v4();

  bool isUplaoding = false;
  final captionController = TextEditingController();
  String? username;

  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;
      // String uid = "fztP1FFujAAWLZi8IHKa";

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        // print(doc['username'] ?? '');
        username = doc['username'];
        // print(uid);
        // print(doc.data());
        print(username);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  //  compressImage() async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   Im.Image? imageFile = Im.decodeImage(image!.readAsBytesSync());
  //   final compressedFile = File('$path/img_$postId.jprg')
  //     ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
  //   image = compressedFile;
  // }

  handleSubmit() {
    String caption = captionController.text;
    String imagePath = widget.imageUrl;

    setState(() {
      isUplaoding = true;
    });

    postRef.doc().set({
      "post_id": postId,
      "likes": 0,
      "comment": [],
      "email": _auth.currentUser!.email,
      "imagepath": imagePath,
      "username": username,
      "caption": caption,
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
              'New post',
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
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: captionController,
                      decoration: InputDecoration(
                          hintText: 'Write a caption',
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 50,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tag people'),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey),
                    top: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 50,
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Add location')),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  // top: BorderSide(width: 1, color: Colors.grey),
                )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 50,
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft, child: Text('Add music')),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  // top: BorderSide(width: 1, color: Colors.grey),
                )),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //       color: Colors.grey,
              //     ),
              //     borderRadius: BorderRadius.only(),
              //   ),
              //   child: ListTile(
              //     title: Text('Add location'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }
}
