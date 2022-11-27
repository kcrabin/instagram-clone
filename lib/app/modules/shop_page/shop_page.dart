import 'package:flutter/material.dart';

import '../homepage/widgets/botton_navigationbar.dart';

class ShopPage extends StatelessWidget {
  // const ShopPage({super.key});

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
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Shop',
          style: TextStyle(
              fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        //  Icon(Icons.arrow_back),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward,
              size: 27,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              size: 27,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
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
                          'Search shops',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 33,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.25),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Videos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 50,
                child: GridView.count(
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  crossAxisCount: 2,
                  children: [...Images],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
