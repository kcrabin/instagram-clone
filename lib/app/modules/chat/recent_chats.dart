import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/models/chat_room_model.dart';
import 'package:instagram_clone/app/models/firebasehelper.dart';
import 'package:instagram_clone/app/modules/chat/chat_page.dart';
import 'package:instagram_clone/app/modules/chat/chatroom_page.dart';

import '../../models/user.dart';
import '../authentication/register/register.dart';

final _auth = FirebaseAuth.instance;

class RecentChats extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  RecentChats({
    super.key,
    required this.firebaseUser,
    required this.userModel,
  });

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  String username = '';
  String email = '';
  String ProfilePic = '';

  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        setState(() {
          username = doc['username'];
          ProfilePic = doc['profilepic'];
          email = doc['email'];
          print(username);
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            Text(
              username,
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 36,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(36),
                                            child: ProfilePic != ''
                                                ? Image.network(ProfilePic)
                                                : Image.network(
                                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          username,
                                          style: TextStyle(
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.blue,
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 34,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 33,
                                        child: ClipOval(
                                            clipBehavior: Clip.hardEdge,
                                            child: Icon(
                                              Icons.add,
                                              size: 35,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Add account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                print('ontap');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                          firebaseUser: widget.firebaseUser,
                          userModel: widget.userModel)),
                );
              },
              child: Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Messages'),
            ),
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatrooms')
                    .where('participants.${widget.userModel.uid}',
                        isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot chatRoomSnapsots =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: chatRoomSnapsots.docs.length,
                        itemBuilder: (context, index) {
                          ChatRoomodel chatRoomodel = ChatRoomodel.fromMap(
                              chatRoomSnapsots.docs[index].data()
                                  as Map<String, dynamic>);
                          Map<String, dynamic> participants =
                              chatRoomodel.participants!;
                          List<String> participantkeys =
                              participants.keys.toList();
                          participantkeys.remove(widget.userModel.uid);

                          return FutureBuilder(
                            future: FirebaseHelper.getUserModelById(
                                participantkeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData != null) {
                                  UserModel targetUser =
                                      userData.data as UserModel;
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatRoomPage(
                                                      chatroom: chatRoomodel,
                                                      firebaseuser:
                                                          widget.firebaseUser,
                                                      targetUser: targetUser,
                                                      userModel:
                                                          widget.userModel)));
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(36),
                                        child: ProfilePic != ''
                                            ? Image.network(targetUser
                                                .profilepic
                                                .toString())
                                            : Image.network(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text(targetUser.username.toString()),
                                    subtitle: (chatRoomodel.lastMessage
                                                .toString() !=
                                            '')
                                        ? Text(
                                            chatRoomodel.lastMessage.toString())
                                        : Text(
                                            'Say hi to your new friend',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: Text('No chats'),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
