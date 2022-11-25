import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({
    Key? key,
  }) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  Color favIconColor = Colors.grey;
  Color bookmarkColor = Colors.grey;

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
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                              child: ClipOval(
                                child: Image.asset(
                                    'assets/newsfeed_photos/storyphoto.PNG'),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John winson',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Pokhara, Nepal',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.more_vert,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: CarouselSlider(
                        items: [
                          SizedBox(
                            // height: 350,
                            child: Image.asset(
                                'assets/newsfeed_photos/gradient.jpeg'),
                          ),
                          SizedBox(
                            height: 350,
                            child: Image.asset(
                                'assets/newsfeed_photos/image1.jpeg'),
                          ),
                          SizedBox(
                            height: 350,
                            child: Image.asset(
                                'assets/newsfeed_photos/image2.jpeg'),
                          ),
                          SizedBox(
                            height: 350,
                            child: Image.asset(
                                'assets/newsfeed_photos/mountain.jpeg'),
                          ),
                        ],
                        options: CarouselOptions(
                            height: 350,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.99),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (favIconColor == Colors.grey) {
                                    favIconColor = Colors.red;
                                  } else {
                                    favIconColor = Colors.grey;
                                  }
                                });
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 33,
                                color: favIconColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/images/comment.png',
                                  height: 35,
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                                onTap: () {
                                  showShareDialog(context);
                                },
                                child: Image.asset(
                                  'assets/images/share.png',
                                  height: 25,
                                )),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (bookmarkColor == Colors.grey) {
                                bookmarkColor = Colors.orange;
                              } else {
                                bookmarkColor = Colors.grey;
                              }
                            });
                          },
                          child: Icon(
                            Icons.bookmark,
                            size: 33,
                            color: bookmarkColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: const [
                        Text('Liked by '),
                        Text(
                          'John ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('and '),
                        Text('others',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'View all 5 comments',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            '28 October',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ),
                      ],
                    ),

                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         'View all 5 comments',
                    //         style: TextStyle(color: Colors.grey),
                    //       )),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
    );
  }
}
