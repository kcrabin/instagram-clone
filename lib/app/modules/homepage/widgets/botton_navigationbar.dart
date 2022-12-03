import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../add_page/add_page.dart';
import '../../profile_page/profile_page.dart';
import '../../search_page/search_page.dart';
import '../../shop_page/shop_page.dart';
import '../home_page.dart';

class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  File? image;
  final imagePicker = ImagePicker();
  String image_path = '';

  Future getImage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image == null) return;
    image_path = image.path;
  }

  // const BottomNavigationBar({
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
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await getImage(ImageSource.camera);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPage(
                                      image_path: image_path,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                await getImage(ImageSource.gallery);
                              },
                              child: Icon(
                                Icons.collections,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
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
                radius: 15,
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
