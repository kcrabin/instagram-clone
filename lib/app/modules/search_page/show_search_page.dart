// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone/app/models/user.dart';

// final userRef = FirebaseFirestore.instance.collection('users');

// class ShowSearch extends StatefulWidget {
//   const ShowSearch({super.key});

//   @override
//   State<ShowSearch> createState() => _ShowSearchState();
// }

// class _ShowSearchState extends State<ShowSearch> {
//   TextEditingController searchController = TextEditingController();
//   Future<QuerySnapshot>? searchResultsFuture;

//   handleSearch(String query) {
//     Future<QuerySnapshot> users =
//         userRef.where('username', isGreaterThanOrEqualTo: query).get();
//     searchResultsFuture = users;
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: SizedBox(
//           height: 37,
//           // height: 50,
//           // width: double.infinity,

//           child: TextFormField(
//             controller: searchController,
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                   onPressed: () {
//                     searchController.clear();
//                   },
//                   icon: Icon(Icons.clear)),
//               labelText: 'Search',
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               contentPadding: EdgeInsets.all(10),
//             ),
//             onFieldSubmitted: handleSearch,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Recent',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text('See All'),
//                 ),
//               ],
//             ),
//             FutureBuilder(
//               future: searchResultsFuture,
//               builder: (context, snapshot) {
//                 final docs = snapshot.data?.docs;
//                 if (!snapshot.hasData) return Text('There is no such user');

//                 List<UserResult> searchResults = [];
//                 snapshot.data?.docs.forEach((doc) {
//                   UserModel user = UserModel.fromDocument(doc);
//                   UserResult searchResult = UserResult(
//                     user: user,
//                   );
//                   searchResults.add(
//                     searchResult,
//                   );
//                 });
//                 return ListView(
//                   shrinkWrap: true,
//                   children: searchResults,
//                 );
//                 // return ListView.builder(
//                 //   shrinkWrap: true,
//                 //   itemBuilder: (context, index) {
//                 //     if (docs != null) final data = docs![index];
//                 //     return ListTile(
//                 //       leading: CircleAvatar(
//                 //         radius: 20,
//                 //         backgroundColor: Colors.grey,
//                 //       ),
//                 //     );
//                 //   },
//                 // );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserResult extends StatelessWidget {
//   final UserModel? user;

//   const UserResult({super.key, this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               radius: 35,
//               backgroundColor: Colors.grey,
//             ),
//             title: Text(
//               user!.username.toString(),
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(user!.email.toString()),
//           )
//         ],
//       ),
//     );
//   }
// }
