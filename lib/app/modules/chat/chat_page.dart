import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/models/chat_room_model.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/chat/chatroom_page.dart';
import 'package:instagram_clone/main.dart';

import '../authentication/register/register.dart';

final _auth = FirebaseAuth.instance;

class ChatPage extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  ChatPage({
    super.key,
    required this.firebaseUser,
    required this.userModel,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController searchController = TextEditingController();
  Future<ChatRoomodel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomodel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${widget.userModel.uid}', isEqualTo: true)
        .where('participants.${targetUser.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatRoomodel existingChatroom =
          ChatRoomodel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatroom;
      // log('chatroom already created');
    } else {
      // log('chatroom not created');
      ChatRoomodel newChatRoom =
          ChatRoomodel(chatroomid: uuid.v1(), lastMessage: '', participants: {
        widget.userModel.uid.toString(): true,
        targetUser.uid.toString(): true,
      });
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatRoom.chatroomid)
          .set(newChatRoom.toMap());

      chatRoom = newChatRoom;

      log('New chatroom created');
    }
    return chatRoom;
  }

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: Icon(Icons.clear)),
                    hintText: 'Search',
                    border: InputBorder.none
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            Center(
              child: CupertinoButton(
                  color: Colors.grey,
                  child: Text('Search'),
                  onPressed: () {
                    setState(() {});
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: searchController.text)
                  .where('email', isNotEqualTo: email)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                    if (dataSnapshot.docs.length > 0) {
                      Map<String, dynamic> userMap =
                          dataSnapshot.docs[0].data() as Map<String, dynamic>;
                      UserModel searchedUser = UserModel.fromMap(userMap);

                      return ListTile(
                        onTap: () async {
                          ChatRoomodel? chatRoomodel =
                              await getChatroomModel(searchedUser);

                          if (chatRoomodel != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatRoomPage(
                                  targetUser: searchedUser,
                                  userModel: widget.userModel,
                                  firebaseuser: widget.firebaseUser,
                                  chatroom: chatRoomodel,
                                ),
                              ),
                            );
                          }
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: ProfilePic != ''
                                ? Image.network(
                                    searchedUser.profilepic.toString())
                                : Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text(
                          searchedUser.username.toString(),
                        ),
                        subtitle: Text(searchedUser.email.toString()),
                        trailing: Icon(
                          Icons.keyboard_arrow_right_sharp,
                          size: 30,
                        ),
                      );
                    } else {
                      return Text('No data found');
                    }
                  } else if (snapshot.hasError) {
                    return Text('An error occoured!');
                  } else {
                    return Text('No results found!');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
