import 'package:flutter/material.dart';

class StoryBar extends StatelessWidget {
  const StoryBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // height: MediaQuery.of(context).size.height / 7,
        height: 100,
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    children: [
                      Stack(alignment: Alignment.bottomRight, children: const [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 36,
                          backgroundImage: ExactAssetImage(
                              'assets/newsfeed_photos/story2.png'),
                        ),
                        Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                        )
                      ]),
                      const Text(
                        'Your Story',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.pink[300],
                      child: CircleAvatar(
                        // backgroundColor: Colors.blueGrey,
                        radius: 33,
                        backgroundImage:
                            ExactAssetImage('assets/newsfeed_photos/view.jpeg'),
                        // child: ClipOval(
                        //   clipBehavior: Clip.hardEdge,

                        //   child:
                        //       Image.asset('assets/newsfeed_photos/story2.png'),
                        // ),
                      ),
                    ),
                    const Text(
                      'John',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
