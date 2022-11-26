import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../homepage/widgets/botton_navigationbar.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 35,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('New post')
          ],
        ),
        //  Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.blue[400],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }
}
