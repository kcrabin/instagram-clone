import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/botton_navigationbar.dart';
import 'package:instagram_clone/app/modules/search_page/show_search_page.dart';

class SearchPage extends StatelessWidget {
  // const SearchPage({super.key});

  // List imgList = [
  //   Image.asset('assets/newsfeed_photos/image1.jpeg'),
  //   Image.asset('assets/newsfeed_photos/image2.jpeg'),
  //   Image.asset('assets/newsfeed_photos/mountain.jpeg'),
  //   Image.asset('assets/newsfeed_photos/story.png'),
  //   Image.asset('assets/newsfeed_photos/story2.png'),
  //   Image.asset('assets/newsfeed_photos/storyphoto.PNG'),
  // ];

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
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text('Search Page')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    print('ontap');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowSearch()),
                    );
                  },
                  child: Container(
                    height: 37,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
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
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 50,
                  child: GridView.count(
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    crossAxisCount: 3,
                    children: [...Images],
                  ),
                  //   GridView.builder(
                  //       itemCount: imgList.length,
                  //       // itemCount: 30,
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3,
                  //         crossAxisSpacing: 2.0,
                  //         mainAxisSpacing: 2.0,
                  //         mainAxisExtent: 85,
                  //       ),
                  //       itemBuilder: (BuildContext context, index) {
                  //         var imageinfo = imgList[index];
                  //         return imageinfo;
                  //         // return Image.asset(
                  //         //     'assets/newsfeed_photos/gradient.jpeg');
                  //       }),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
