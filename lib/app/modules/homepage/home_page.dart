import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/add_page/add_page.dart';
import 'package:instagram_clone/app/modules/profile_page/profile_page.dart';
import 'package:instagram_clone/app/modules/search_page/search_page.dart';
import 'package:instagram_clone/app/modules/shop_page/shop_page.dart';

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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ),
              );
            },
            child: const Icon(
              Icons.home,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            child: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ),
              );
            },
            child: const Icon(
              Icons.add_box_outlined,
              size: 40,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopPage(),
                ),
              );
            },
            child: const Icon(
              Icons.local_mall_outlined,
              size: 30,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
            child: const Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
