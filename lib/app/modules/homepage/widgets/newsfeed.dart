import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/authentication/widgets/input_field.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/suggestions.dart';

import 'caughtup_container.dart';

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
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          // scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Padding(
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
                            child: ClipOval(
                              child: Image.asset(
                                  'assets/newsfeed_photos/storyphoto.PNG'),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Container(
                  height: 250,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: CarouselSlider(
                    items: [
                      SizedBox(
                        // height: 350,
                        child:
                            Image.asset('assets/newsfeed_photos/gradient.jpeg'),
                      ),
                      SizedBox(
                        height: 350,
                        child:
                            Image.asset('assets/newsfeed_photos/image1.jpeg'),
                      ),
                      SizedBox(
                        height: 350,
                        child:
                            Image.asset('assets/newsfeed_photos/image2.jpeg'),
                      ),
                      SizedBox(
                        height: 350,
                        child:
                            Image.asset('assets/newsfeed_photos/mountain.jpeg'),
                      ),
                    ],
                    options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                  child: Row(
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
                              size: 27,
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
                                height: 28,
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
                                height: 20,
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
                          Icons.bookmark_border_sharp,
                          size: 27,
                          color: bookmarkColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 3,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  child: Row(
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
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  child: Row(
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('caption ...........'),
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
                        onTap: () {},
                        child: const Text(
                          'View all 5 comments',
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
                      const CircleAvatar(
                        radius: 15,
                        backgroundImage: ExactAssetImage(
                            'assets/newsfeed_photos/story2.png'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          InputField(
                              hint: 'Add a comment',
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.text);
                        },
                        child: const Text(
                          'Add a comment...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  child: Row(
                    children: const [
                      Text(
                        '28 October',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
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
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Suggested for you'),
                    TextButton(onPressed: () {}, child: Text('See all'))
                  ],
                ),
                Suggestions(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 27,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Icon(
              Icons.check,
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        CaughtUpContainer(),
      ],
    );
  }
}
