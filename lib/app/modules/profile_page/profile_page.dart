import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/botton_navigationbar.dart';

import 'widgets/edit_profile_container.dart';
import 'widgets/highlights_container.dart';
import 'widgets/userinfo_container.dart';

class Profile extends StatelessWidget {
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
              color: Colors.black,
            ),
            Text(
              'Username',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Icon(
              Icons.expand_more,
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
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
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
                height: 15,
              ),
              const EditProfileContainer(),
              const SizedBox(
                height: 20,
              ),
              HighlightsContainer(),
              const SizedBox(
                height: 20,
              ),
              Container(
                // height: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.grid_on,
                          size: 30,
                        ),
                        Icon(
                          Icons.video_library_outlined,
                          size: 30,
                        ),
                        Icon(
                          Icons.tag,
                          size: 30,
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 50,
                      child: GridView.count(
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                        crossAxisCount: 3,
                        children: [...Images],
                      ),
                    ),
                  ],
                ),
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
