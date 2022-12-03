import 'package:flutter/material.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 7, 8),
          child: Container(
            // height: 450,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.close,
                        size: 20,
                      )),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        ExactAssetImage('assets/newsfeed_photos/image1.jpeg'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'prashant grg',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: ExactAssetImage(
                            'assets/newsfeed_photos/image1.jpeg'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Followed by confess_gces,',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(
                            'kcRabin and 25 more',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(27), elevation: 0),
                      child: Text('Follow'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
