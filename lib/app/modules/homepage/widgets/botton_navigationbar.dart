import 'package:flutter/material.dart';

import '../../add_page/add_page.dart';
import '../../profile_page/profile_page.dart';
import '../../search_page/search_page.dart';
import '../../shop_page/shop_page.dart';
import '../home_page.dart';

class BottomBar extends StatelessWidget {
  // const BottomNavigationBar({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: BottomAppBar(
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
                Icons.home_filled,
                size: 25,
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
                size: 27,
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
                size: 25,
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
                size: 24,
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
              child: const CircleAvatar(
                radius: 13,
                backgroundImage:
                    ExactAssetImage('assets/newsfeed_photos/story2.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
