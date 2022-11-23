import 'package:flutter/material.dart';

class StoryBar extends StatelessWidget {
  const StoryBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height / 7,
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                child:
                    // Image.asset(
                    //   'assets/images/person2',
                    //   height: 20,
                    // )
                    Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Text('Name'),
            ],
          ),
        ),
      ),
    );
  }
}
