import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/chat/chat_page.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/botton_navigationbar.dart';
import 'package:instagram_clone/app/modules/search_page/show_search_page.dart';

import '../../models/firebasehelper.dart';
import '../../models/user.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text('Search Page')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 10),
                child: InkWell(
                  onTap: () {
                    print('ontap');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                              firebaseUser: currentUser!,
                              userModel: thisUserModel!)),
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                child: Text('Search users'),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
