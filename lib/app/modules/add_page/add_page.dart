import 'dart:io';

import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final String image_path;
  AddPage({super.key, required this.image_path});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final captionController = TextEditingController();

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 35,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'New post',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        //  Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.check,
              size: 35,
              color: Colors.blue[400],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: Image.file(
                      File(widget.image_path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      // controller: captionController,
                      decoration: InputDecoration(
                          hintText: 'Write a caption',
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 50,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tag people'),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey),
                    top: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 50,
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Add location')),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  // top: BorderSide(width: 1, color: Colors.grey),
                )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 50,
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft, child: Text('Add music')),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  // top: BorderSide(width: 1, color: Colors.grey),
                )),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //       color: Colors.grey,
              //     ),
              //     borderRadius: BorderRadius.only(),
              //   ),
              //   child: ListTile(
              //     title: Text('Add location'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }
}
