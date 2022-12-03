import 'package:flutter/material.dart';

class UserInfoContainer extends StatelessWidget {
  const UserInfoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              // backgroundColor: Colors.blueGrey,
              radius: 38,
              backgroundImage:
                  ExactAssetImage('assets/newsfeed_photos/story2.png'),
              // child: ClipOval(
              //   clipBehavior: Clip.hardEdge,

              //   child:
              //       Image.asset('assets/newsfeed_photos/story2.png'),
              // ),
            ),
            const Text(
              'Username',
              style: TextStyle(
                  // fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        Column(
          children: const [
            Text(
              '29',
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
        ),
        Column(
          children: const [
            Text(
              '139',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Followers',
              style: TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: const [
            Text(
              '132',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Followings',
              style: TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 2,
        )
      ],
    );
  }
}
