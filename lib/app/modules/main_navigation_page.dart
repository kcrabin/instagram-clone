import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/modules/add_page/addpage.dart';
import 'package:instagram_clone/app/modules/homepage/home_page.dart';
import 'package:instagram_clone/app/modules/profile_page/profile_page.dart';
import 'package:instagram_clone/app/modules/search_page/search_page.dart';
import 'package:instagram_clone/app/modules/shop_page/shop_page.dart';

import 'add_page/add_post_page.dart';
import 'authentication/register/register.dart';

final _auth = FirebaseAuth.instance;

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _firebaseStorage = FirebaseStorage.instance;

  String profilePic = '';
  String profilePicToDisplay = '';

  File? image;
  final imagePicker = ImagePicker();
  String imageUrl = '';
  bool isUploading = false;

  Future getImage(ImageSource source) async {
    setState(() {
      isUploading = true;
    });
    // if (isUploading == true) {
    //   Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    final image = await imagePicker.pickImage(source: source);
    if (image == null) return;
    var file = File(image.path);
    String imageName = image.path.split('/').last;
    var snapshot =
        await _firebaseStorage.ref().child('images/$imageName').putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      print(downloadUrl);
      imageUrl = downloadUrl;

      isUploading = false;
    });
  }

  int currentIndex = 0;

  final screens = [
    Homepage(),
    SearchPage(),
    AddPageFake(),
    ShopPage(),
    Profile()
  ];

  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        if (doc['profilepic'] != '') {
          setState(() {
            profilePicToDisplay = doc['profilepic'];
          });
        } else {
          print('no profilepic print from navigationbar');
        }
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 25,
                ),
                label: 'Home page'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 27,
                ),
                label: 'Search page'),
            BottomNavigationBarItem(
                icon: InkWell(
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
                                          imageUrl: imageUrl,
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

                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddPage(
                                          imageUrl: imageUrl,
                                        ),
                                      ),
                                    );
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
                  child: Icon(
                    Icons.collections,
                    size: 30,
                  ),
                ),
                label: 'Add page'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_mall_outlined,
                  size: 24,
                ),
                label: 'Shop page'),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: (profilePicToDisplay != '')
                        ? Image.network(profilePicToDisplay)
                        : Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                label: 'profile'),
          ]),
    );
  }
}
