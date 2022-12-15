// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../add_page/add_post_page.dart';
// import '../../authentication/register/register.dart';
// import '../../profile_page/profile_page.dart';
// import '../../search_page/search_page.dart';
// import '../../shop_page/shop_page.dart';
// import '../home_page.dart';

// final _auth = FirebaseAuth.instance;

// class BottomBar extends StatefulWidget {
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   final _firebaseStorage = FirebaseStorage.instance;

//   String profilePic = '';
//   String profilePicToDisplay = '';

//   File? image;
//   final imagePicker = ImagePicker();
//   String imageUrl = '';
//   // String postId = Uuid().v4();

//   Future getImage(ImageSource source) async {
//     final image = await imagePicker.pickImage(source: source);
//     if (image == null) return;
//     var file = File(image.path);
//     String imageName = image.path.split('/').last;
//     var snapshot =
//         await _firebaseStorage.ref().child('images/$imageName').putFile(file);
//     var downloadUrl = await snapshot.ref.getDownloadURL();
//     setState(() {
//       print(downloadUrl);
//       imageUrl = downloadUrl;
//     });
//   }

//   @override
//   void initState() {
//     try {
//       String? uid = _auth.currentUser!.uid;

//       userRef.doc(uid).get().then((DocumentSnapshot doc) {
//         if (doc['profilepic'] != '') {
//           setState(() {
//             profilePicToDisplay = doc['profilepic'];
//           });
//         } else {
//           print('no profilepic print from navigationbar');
//         }

//         // setState(() {
//         //   ProfilePic = doc['profilepic'];
//         //   // print(ProfilePic);
//         // });
//       });
//     } catch (e) {
//       print(e);
//     }
//     super.initState();
//   }

//   // const BottomNavigationBar({
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(7.0),
//       child: BottomAppBar(
//         elevation: 0,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Homepage(),
//                   ),
//                 );
//               },
//               child: const Icon(
//                 Icons.home_filled,
//                 size: 25,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SearchPage(),
//                   ),
//                 );
//               },
//               child: const Icon(
//                 Icons.search,
//                 size: 27,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         height: 60,
//                         decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40),
//                         )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 await getImage(ImageSource.camera);
//                                 Navigator.pop(context);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => AddPage(
//                                       imageUrl: imageUrl,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Icon(
//                                 Icons.camera_alt_outlined,
//                                 size: 30,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 30,
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 await getImage(ImageSource.gallery);
//                                 Navigator.pop(context);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => AddPage(
//                                       imageUrl: imageUrl,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Icon(
//                                 Icons.collections,
//                                 size: 30,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     });
//               },
//               child: const Icon(
//                 Icons.add_box_outlined,
//                 size: 25,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ShopPage(),
//                   ),
//                 );
//               },
//               child: const Icon(
//                 Icons.local_mall_outlined,
//                 size: 24,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Profile(),
//                   ),
//                 );
//               },
//               child: CircleAvatar(
//                 radius: 15,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(36),
//                   child: (profilePicToDisplay != '')
//                       ? Image.network(profilePicToDisplay)
//                       : Image.network(
//                           'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
