import 'package:flutter/material.dart';

class HighlightsContainer extends StatelessWidget {
  const HighlightsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 36,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 34,
                        backgroundImage: ExactAssetImage(
                            'assets/newsfeed_photos/highlights.jpeg'),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Highlights'),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 34,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 33,
                      child: ClipOval(
                          clipBehavior: Clip.hardEdge,
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Text('New'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
