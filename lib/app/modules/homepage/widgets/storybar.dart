import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  String profilePic = '';
  String profilePicToDisplay = '';

  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        if (doc['profilepic'] != '') {
          setState(() {
            profilePicToDisplay = doc['profilepic'];
          });
        } else {
          print('no profilepic');
        }
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  // displayProfileOnStorybar() {
  //   setState(() {
  //     profilePicToDisplay = profilePic;
  //     // print(ProfilePic);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // height: MediaQuery.of(context).size.height / 7,
        height: 100,
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    children: [
                      Stack(alignment: Alignment.bottomRight, children: [
                        // ClipRRect(
                        //   child: Image.network(
                        //     ProfilePic,
                        //   ),
                        // ),
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
                        Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                        )
                      ]),
                      const Text(
                        'Your Story',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.pink[300],
                      child: CircleAvatar(
                        // backgroundColor: Colors.blueGrey,
                        radius: 33,
                        backgroundImage:
                            ExactAssetImage('assets/newsfeed_photos/view.jpeg'),
                      ),
                    ),
                    const Text(
                      'John',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
