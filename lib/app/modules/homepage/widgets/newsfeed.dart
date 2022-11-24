import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
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
                            Text('John winson'),
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
                              onTap: () {},
                              child: const Icon(
                                Icons.favorite_border,
                                size: 33,
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
                                onTap: () {},
                                child: Image.asset(
                                  'assets/images/share.png',
                                  height: 25,
                                )),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.turned_in_not_outlined,
                            size: 33,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: const [
                        Text('Liked by'),
                        Text('John'),
                        Text('and'),
                        Text('others')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
    );
  }
}
