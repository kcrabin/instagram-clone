import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/homepage/widgets/suggestions.dart';

import 'widgets/botton_navigationbar.dart';
import 'widgets/newsfeed.dart';
import 'widgets/storybar.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/images/logo1.png',
                width: 120,
              ),
            ),
            Icon(
              Icons.expand_more,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_outline,
              color: Colors.black,
              size: 35,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/messanger.png',
                  height: 40,
                  width: 31,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StoryBar(),
            NewsFeed(),
            // Suggestions(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
