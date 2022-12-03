// import 'package:flutter/material.dart';
// import 'package:instagram_clone/app/modules/profile_page/edit_profile.dart';

// class EditProfileContainer extends StatelessWidget {
//   String email;
//   String username;
//   String fullname;
//    EditProfileContainer({
//     required this.email, required this.fullname, required this.username
//   });


//   @override
//   Widget build(BuildContext context) {

    
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => EditProfile(email: , username: , fullname: , )));
//             },
//             child: Container(
//               height: 35,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey.withOpacity(0.25),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Edit Profile',
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//             height: 35,
//             width: 40,
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.25),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: const Padding(
//                 padding: EdgeInsets.all(3),
//                 child: Icon(
//                   Icons.person_add_outlined, size: 20,
//                   // color: Colors.white,
//                 )),
//           ),
//         ),
//       ],
//     );
//   }
// }
