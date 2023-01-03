import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/authentication/register/register.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/comment_page.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/suggestions.dart';

import 'caughtup_container.dart';

final postRef = FirebaseFirestore.instance.collection('post');
final _auth = FirebaseAuth.instance;

class NewsFeed extends StatefulWidget {
  const NewsFeed({
    Key? key,
  }) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  // bool? isLiked;

  TextEditingController commentController = TextEditingController();
  String profilePic = '';
  String username = '';
  String currentUserEmail = '';

  final String currentUserId = userRef.id;
  late int likeCount;

  Color favIconColor = Colors.grey;

  showShareDialog(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Share'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Alert !"),
      content: const Text("Do you want to share the photo?"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    getPosts();

    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        setState(() {
          profilePic = doc['profilepic'];
          username = doc['username'];
          currentUserEmail = doc['email'];

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

  addComment(id) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('post').doc(id);
    if (commentController.text != '') {
      setState(() {
        docRef.update({
          'comment': FieldValue.arrayUnion([
            {
              'comment': commentController.text,
              'name': username == null ? 'Rabin' : username,
              'created_at': DateTime.now(),
              'commentorProfile': profilePic,
            }
          ])
        });
        commentController.clear();
      });
    }
  }

  Future getLike(id) async {
    var value = await FirebaseFirestore.instance
        .collection('post')
        .doc(id)
        .get()
        .then((value) {
      return value.data()!['likedBy'];
    });
    print('like value $value');
    return value.contains(FirebaseAuth.instance.currentUser!.email);
  }

  Future getBookmarked(id) async {
    var value = await FirebaseFirestore.instance
        .collection('post')
        .doc(id)
        .get()
        .then((value) {
      return value.data()!['bookmarkedBy'];
    });
    print('bookmark value $value');
    return value.contains(FirebaseAuth.instance.currentUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('post').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: docs.length,
                      // scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final data = docs[index];
                        String postId = data.id;
                        String postOwner = data.get('username');
                        String ownerEmail = data.get('email');
                        String caption = data.get('caption');
                        String postOwnerProfile = data.get('postOwnerProfile');
                        List likers = data.get('likedBy');
                        int likes = likers.length;
                        List bookmarkers = data.get('bookmarkedBy');
                        String location = data.get('location');
                        // if(bookmarkedBy.contains(''))
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 20,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(36),
                                            child: (postOwnerProfile != '')
                                                ? Image.network(
                                                    postOwnerProfile)
                                                : Image.network(
                                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   'John winson',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold),
                                            // ),
                                            Text(
                                              data.get('username'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              location,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(data);
                                          print(
                                              'this is form 3 dots ${likers}');
                                        },
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              GestureDetector(
                                // onDoubleTap: handleLikePost(),
                                child: Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                  child: Image.network(
                                    data.get(
                                      'imagepath',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  // Text(data!['username']),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              like() async {
                                                // print(getLike(postId));
                                                DocumentReference docRef =
                                                    FirebaseFirestore.instance
                                                        .collection('post')
                                                        .doc(postId);
                                                bool isLiked =
                                                    await getLike(postId);

                                                if (isLiked) {
                                                  docRef.update({
                                                    'likedBy':
                                                        FieldValue.arrayRemove([
                                                      FirebaseAuth.instance
                                                          .currentUser!.email
                                                    ])
                                                  });
                                                } else {
                                                  docRef.update({
                                                    'likedBy':
                                                        FieldValue.arrayUnion([
                                                      FirebaseAuth.instance
                                                          .currentUser!.email
                                                    ])
                                                  });
                                                }
                                              }

                                              like();
                                            },
                                            icon: (likers
                                                    .contains(currentUserEmail))
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    size: 27,
                                                  )
                                                : Icon(Icons
                                                    .favorite_border_outlined)),
                                        // const SizedBox(
                                        //   width: 15,
                                        // ),
                                        // InkWell(
                                        //     onTap: () {
                                        //       showShareDialog(context);
                                        //     },
                                        //     child: Image.asset(
                                        //       'assets/images/share.png',
                                        //       height: 20,
                                        //     )),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          bookmark() async {
                                            // print(getLike(postId));
                                            DocumentReference docRef =
                                                FirebaseFirestore.instance
                                                    .collection('post')
                                                    .doc(postId);
                                            bool isLiked =
                                                await getBookmarked(postId);

                                            if (isLiked) {
                                              docRef.update({
                                                'bookmarkedBy':
                                                    FieldValue.arrayRemove([
                                                  FirebaseAuth.instance
                                                      .currentUser!.email
                                                ])
                                              });
                                            } else {
                                              docRef.update({
                                                'bookmarkedBy':
                                                    FieldValue.arrayUnion([
                                                  FirebaseAuth.instance
                                                      .currentUser!.email
                                                ])
                                              });
                                            }
                                          }

                                          bookmark();
                                        },
                                        icon: (bookmarkers
                                                .contains(currentUserEmail))
                                            ? Icon(
                                                Icons.bookmark_added,
                                                color: Colors.orange,
                                                size: 27,
                                              )
                                            : Icon(
                                                Icons.bookmark_add_outlined)),
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 3,
                              // ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 8, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      likes.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('likes'),
                                    // Text('and '),
                                    // Text('others',
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      data.get('username'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(data.get('caption')),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentPage(
                                                      postCaption: caption,
                                                      email: ownerEmail,
                                                      username: postOwner,
                                                      postid: postId,
                                                    )));
                                      },
                                      child: const Text(
                                        'View all comments',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 3,
                              // ),

                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 15,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(36),
                                        child: (profilePic != '')
                                            ? Image.network(profilePic)
                                            : Image.network(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width *
                                          0.84,
                                      child: TextFormField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                addComment(postId);
                                              },
                                              icon: Text(
                                                'Post',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                          hintText: 'Add a comment',
                                          border: InputBorder.none,
                                          // UnderlineInputBorder(
                                          //   borderSide: BorderSide(color: Colors.grey),
                                          // ),
                                          // contentPadding: EdgeInsets.all(10),
                                        ),

                                        // onFieldSubmitted: handleSearch,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      data.get('time').toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text('No posts'),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Suggested for you'),
                    TextButton(onPressed: () {}, child: Text('See all'))
                  ],
                ),
                Suggestions(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 27,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Icon(
              Icons.check,
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        CaughtUpContainer(),
      ],
    );
  }
}
