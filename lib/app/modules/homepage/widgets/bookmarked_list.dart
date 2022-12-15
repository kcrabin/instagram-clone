import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/register/register.dart';
import 'comment_page.dart';

final _auth = FirebaseAuth.instance;

class BookmarkedList extends StatefulWidget {
  BookmarkedList({super.key});

  @override
  State<BookmarkedList> createState() => _BookmarkedListState();
}

class _BookmarkedListState extends State<BookmarkedList> {
  TextEditingController commentController = TextEditingController();
  String profilePic = '';
  String username = '';
  String currentUserEmail = '';
  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        setState(() {
          currentUserEmail = doc['email'];
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Saved',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('post')
              // .where('bookmarkedBy', isEqualTo: currentUserEmail)
              .snapshots(),
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs;
            if (!snapshot.hasData) return new Text('Loading');

            return ListView.builder(
                itemCount: docs?.length,
                itemBuilder: (context, index) {
                  final data = docs![index];
                  String postId = data.id;
                  String postOwner = data.get('username');
                  String ownerEmail = data.get('email');
                  String caption = data.get('caption');
                  String postOwnerProfile = data.get('postOwnerProfile');
                  List likers = data.get('likedBy');
                  int likes = likers.length;
                  List bookmarkers = data.get('bookmarkedBy');
                  if (bookmarkers.contains(currentUserEmail)) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 20,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(36),
                                        child: (postOwnerProfile != '')
                                            ? Image.network(postOwnerProfile)
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
                                          'Pokhara, Nepal',
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
                                      print('this is form 3 dots ${likers}');
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        icon:
                                            (likers.contains(currentUserEmail))
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    size: 27,
                                                  )
                                                : Icon(Icons
                                                    .favorite_border_outlined)),
                                    const SizedBox(
                                      width: 15,
                                    ),
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
                                      DocumentReference docRef =
                                          FirebaseFirestore.instance
                                              .collection('post')
                                              .doc(postId);
                                      docRef.update({
                                        'bookmarkedBy': FieldValue.arrayRemove([
                                          FirebaseAuth
                                              .instance.currentUser!.email
                                        ])
                                      });

                                      // bookmark() async {
                                      //   // print(getLike(postId));
                                      //   DocumentReference docRef =
                                      //       FirebaseFirestore.instance
                                      //           .collection('post')
                                      //           .doc(postId);
                                      //   bool isLiked =
                                      //       await getBookmarked(postId);

                                      //   if (isLiked) {
                                      //     docRef.update({
                                      //       'bookmarkedBy':
                                      //           FieldValue.arrayRemove([
                                      //         FirebaseAuth
                                      //             .instance.currentUser!.email
                                      //       ])
                                      //     });
                                      //   } else {
                                      //     docRef.update({
                                      //       'bookmarkedBy':
                                      //           FieldValue.arrayUnion([
                                      //         FirebaseAuth
                                      //             .instance.currentUser!.email
                                      //       ])
                                      //     });
                                      //   }
                                      // }

                                      // bookmark();
                                    },
                                    icon: (bookmarkers
                                            .contains(currentUserEmail))
                                        ? Icon(
                                            Icons.bookmark_added,
                                            color: Colors.orange,
                                            size: 27,
                                          )
                                        : Icon(Icons.bookmark_add_outlined)),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                            builder: (context) => CommentPage(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.84,
                                  child: TextFormField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            addComment(postId);
                                          },
                                          icon: Text(
                                            'Post',
                                            style:
                                                TextStyle(color: Colors.blue),
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
                  } else {
                    return Center(
                      child: Text('No bookmarks'),
                    );
                  }
                });
          }),
    );
  }
}
