import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/botton_navigationbar.dart';

import 'widgets/edit_profile_container.dart';
import 'widgets/highlights_container.dart';
import 'widgets/userinfo_container.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // const Profile({super.key});
  final List<Image> Images = const [
    Image(
      image: AssetImage('assets/newsfeed_photos/image1.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image2.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/mountain.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/story.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/storyphoto.PNG'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image1.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image2.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/mountain.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/storyphoto.PNG'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image1.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image2.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/mountain.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/story.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/storyphoto.PNG'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image1.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/image2.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/mountain.jpeg'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/newsfeed_photos/storyphoto.PNG'),
      fit: BoxFit.cover,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(
              Icons.lock_outline,
              size: 15,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Username',
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
              const UserInfoContainer(),
              const SizedBox(
                height: 25,
              ),
              const EditProfileContainer(),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 50,
                    child: GridView.count(
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      crossAxisCount: 3,
                      children: [...Images],
                    ),
                  ),
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
