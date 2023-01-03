import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/modules/add_page/add_story_page.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/story_view.dart';

import '../../authentication/register/register.dart';

final _auth = FirebaseAuth.instance;

class StoryBar extends StatefulWidget {
  const StoryBar({
    Key? key,
  }) : super(key: key);

  @override
  State<StoryBar> createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  final _firebaseStorage = FirebaseStorage.instance;

  String profilePic = '';
  String profilePicToDisplay = '';

  File? image;
  final imagePicker = ImagePicker();
  String imageUrl = '';

  Future getImage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image == null) return;
    var file = File(image.path);
    String imageName = image.path.split('/').last;
    var snapshot =
        await _firebaseStorage.ref().child('images/$imageName').putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      print(downloadUrl);
      imageUrl = downloadUrl;
    });
  }

  void getStoryFromFirebase() {
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        if (doc['profilepic'] != '') {
          profilePicToDisplay = doc['profilepic'];
          setState(() {});
        } else {
          print('no profilepic');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getStoryFromFirebase();
    super.initState();
  }
  // @override
  // void initState() {
  //   try {
  //     String? uid = _auth.currentUser!.uid;

  //     userRef.doc(uid).get().then((DocumentSnapshot doc) {
  //       setState(() {
  //         profilePic = doc['profilepic'];

  //         print(profilePic);
  //       });
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // height: MediaQuery.of(context).size.height / 7,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddStoryPage(imageUrl: imageUrl),
                                        ),
                                      );
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddStoryPage(imageUrl: imageUrl),
                                        ),
                                      );
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
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 36,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: (profilePicToDisplay != '')
                              ? Image.network(profilePicToDisplay)
                              : Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 12,
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                        ),
                      )
                    ]),
                  ),
                  const Text(
                    'Your Story',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('story')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index];
                            String storyOwner = data.get('username');
                            String story = data.get('imagepath');
                            String storyOwnerProfile =
                                data.get('storyOwnerProfile');

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StoryView(
                                            storyImage: story,
                                            username: storyOwner,
                                            storyOwnerPic: storyOwnerProfile,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 36,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(36),
                                        child: (storyOwnerProfile != '')
                                            ? Image.network(storyOwnerProfile)
                                            : Image.network(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    storyOwner,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text('No story'),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
