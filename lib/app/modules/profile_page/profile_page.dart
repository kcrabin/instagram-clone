import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/botton_navigationbar.dart';
import 'package:instagram_clone/app/modules/profile_page/edit_profile.dart';

import '../authentication/register/register.dart';
import 'widgets/highlights_container.dart';
import 'widgets/userinfo_container.dart';

final postRef = FirebaseFirestore.instance.collection('post');

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';
  String username = '';
  String fullname = '';
  String userId = '';
  String profilePic = '';

  int postCount = 0;

  @override
  void initState() {
    getPosts();
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        setState(() {
          email = doc['email'];
          username = doc['username'];
          fullname = doc['fullname'];
          profilePic = doc['profilepic'];

          userId = uid;
          print(email);
          print(username);
          print(fullname);
          print(userId);
          print(profilePic);
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  getPosts() {
    postRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data);
      });
    });
  }

  // const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.lock_outline,
              size: 15,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              username,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Icon(
              Icons.expand_more,
              size: 20,
              color: Colors.black,
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
                size: 27,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                        child: Wrap(
                          children: [
                            ListTile(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                setState(() {
                                  print("setting pressed");
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                                // );
                              },
                              leading: Icon(Icons.settings),
                              title: Text('Settings'),
                            ),
                            ListTile(
                              leading: Icon(Icons.history),
                              title: Text('Your activity'),
                            ),
                            ListTile(
                              leading: Icon(Icons.archive_outlined),
                              title: Text('Archive'),
                            ),
                            ListTile(
                              leading: Icon(Icons.qr_code_rounded),
                              title: Text('QR Code'),
                            ),
                            ListTile(
                              leading: Icon(Icons.bookmark_border_sharp),
                              title: Text('Saved'),
                            ),
                            ListTile(
                              leading: Icon(Icons.verified),
                              title: Text('Digital Collectibles'),
                            ),
                            ListTile(
                              leading: Icon(Icons.group),
                              title: Text('Close friends'),
                            ),
                            ListTile(
                              leading: Icon(Icons.star_border),
                              title: Text('Favourites'),
                            ),
                            ListTile(
                              leading: Icon(Icons.format_align_center_outlined),
                              title: Text('Covid-19 Information Centre'),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 27,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              UserInfoContainer(
                username: username,
                postCount: postCount,
                profilepic: profilePic,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              fullname: fullname,
                              username: username,
                              userIdToUpdate: userId,
                              profilePic: profilePic,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.25),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 35,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.25),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Padding(
                          padding: EdgeInsets.all(3),
                          child: Icon(
                            Icons.person_add_outlined, size: 20,
                            // color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
              // EditProfileContainer(
              //     email: email, fullname: fullname, username: username),
              const SizedBox(
                height: 20,
              ),
              const HighlightsContainer(),
              const SizedBox(
                height: 20,
              ),

              // TabBar(
              //   tabs: [
              //     Icon(Icons.grid_on),
              //     Icon(Icons.video_collection_outlined),
              //     Icon(Icons.tag)

              //   ],

              // ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        // flex: 2,
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          child: const Icon(
                            Icons.grid_on,
                            size: 23,
                          ),
                        ),
                      ),
                      Expanded(
                        // flex: 2,
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.video_library_outlined,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                      ),
                      Expanded(
                        // flex: 2,
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.tag,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  new StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('post')
                          .where('email', isEqualTo: email)
                          .snapshots(),
                      builder: ((BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        final docs = snapshot.data?.docs;
                        if (docs != null) postCount = docs.length;

                        if (!snapshot.hasData) return new Text('Loading');

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 170,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: docs?.length,
                          itemBuilder: (context, index) {
                            final data = docs![index];
                            String post_email = data.get('email');

                            return post_email == email
                                ? Image.network(
                                    data.get(
                                      'imagepath',
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox();
                          },
                        );
                      }))
                ],
              )

              // FloatingActionButton(
              //   onPressed: () {
              //     FirebaseAuth.instance.signOut();
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Login_Page(),
              //       ),
              //     );
              //   },
              //   child: Text('Logout'),
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
