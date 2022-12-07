import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/models/firebasehelper.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/chat/chat_page.dart';
import 'package:instagram_clone/app/modules/chat/recent_chats.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/suggestions.dart';

import 'widgets/botton_navigationbar.dart';
import 'widgets/newsfeed.dart';
import 'widgets/storybar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UserModel? thisUserModel;
  User? currentUser;

  getUserModel() async {
    thisUserModel = await FirebaseHelper.getUserModelById(currentUser!.uid);
  }

  @override
  void initState() {
    // getUserModel();
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;

      // thisUserModel = await FirebaseHelper.getUserModelById(currentUser!.uid);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/images/logo1.png',
                width: 120,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.expand_more,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_outline,
              color: Colors.black,
              size: 35,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  // print('data $thisUserModel');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecentChats(
                          firebaseUser: currentUser!,
                          userModel: thisUserModel!),
                    ),
                    // ChatPage(
                    //     firebaseUser: currentUser!,
                    //     userModel: thisUserModel!),
                    // ),
                  );
                },
                child: Image.asset(
                  'assets/images/messanger.png',
                  height: 35,
                  width: 30,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoryBar(),
            NewsFeed(),
            // Suggestions(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
