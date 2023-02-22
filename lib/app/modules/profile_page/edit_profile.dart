import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/modules/profile_page/profile_page.dart';

final updateRef = FirebaseFirestore.instance.collection('users');

class EditProfile extends StatefulWidget {
  String profilePic = '';
  String username = '';
  String fullname = '';
  String userIdToUpdate = '';

  EditProfile(
      {super.key,
      required this.profilePic,
      required this.fullname,
      required this.username,
      required this.userIdToUpdate});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firebaseStorage = FirebaseStorage.instance;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();

  @override
  void dispose() {
    usernamecontroller.dispose();
    fullnamecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    usernamecontroller.text = widget.username;
    fullnamecontroller.text = widget.fullname;
    imageUrl = widget.profilePic;

    super.initState();
  }

  File? image;
  final imagePicker = ImagePicker();
  String? imageUrl;

  Future getImage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image == null) return;
    var file = File(image.path);
    String imageName = image.path.split('/').last;
    var snapshot =
        await _firebaseStorage.ref().child('profile/$imageName').putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      print(downloadUrl);
      imageUrl = downloadUrl;
    });
  }

  Update() {
    String username = usernamecontroller.text;
    String fullname = fullnamecontroller.text;

    updateRef
        .doc(widget.userIdToUpdate)
        .update({
          'fullname': fullname,
          'username': username,
          'timestamp': Timestamp.fromDate(DateTime.now()),
          'profilepic': imageUrl,
        })
        .then((_) => print('updated'))
        .catchError((e) => print('update failed: $e'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print(widget.fullname);
                print(widget.username);
                print(widget.userIdToUpdate);
                Update();

                Navigator.pop(context);
              },
              icon: Icon(
                Icons.done,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                child: (imageUrl != '')
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Text(
                        'Choose a Profile Picture',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await getImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () async {
                                  await getImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.collections,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text('Edit Picture or avatar'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: fullnamecontroller,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  contentPadding: EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Full name";
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: usernamecontroller,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  contentPadding: EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Username";
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
