import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfoContainer extends StatefulWidget {
  String username;
  String email;
  int postCountToDisplay = 0;
  String profilepic;
  UserInfoContainer(
      {Key? key,
      required this.username,
      required this.email,
      required this.profilepic})
      : super(key: key);

  @override
  State<UserInfoContainer> createState() => _UserInfoContainerState();
}

class _UserInfoContainerState extends State<UserInfoContainer> {
  int postCount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 38,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: widget.profilepic != ''
                    ? Image.network(widget.profilepic)
                    : Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg'),
              ),
            ),
            Text(
              widget.username,
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('post')
                .where('email', isEqualTo: widget.email)
                .snapshots(),
            builder: (context, snapshots) {
              final docs = snapshots.data?.docs;
              if (docs != null) postCount = docs.length;
              return Column(
                children: [
                  Text(
                    postCount.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),

        // Column(
        //   children: const [
        //     Text(
        //       '139',
        //       style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     Text(
        //       'Followers',
        //       style: TextStyle(
        //         fontSize: 12,
        //         // fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ],
        // ),
        // Column(
        //   children: const [
        //     Text(
        //       '132',
        //       style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     Text(
        //       'Followings',
        //       style: TextStyle(
        //         fontSize: 12,
        //         // fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          width: 2,
        )
      ],
    );
  }
}
