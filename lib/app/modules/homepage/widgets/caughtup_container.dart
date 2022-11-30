import 'package:flutter/material.dart';

class CaughtUpContainer extends StatelessWidget {
  const CaughtUpContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('You\'ve completely caught up'),
        SizedBox(
          height: 15,
        ),
        Text(
          'You\'ve seen all new posts from the past 3 days.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(
          height: 17,
        ),
        TextButton(onPressed: () {}, child: Text('View Older Posts'))
      ],
    );
  }
}
