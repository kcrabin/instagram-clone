import 'package:flutter/material.dart';

class StoryView extends StatefulWidget {
  String? storyImage;
  String? username;
  String? storyOwnerPic;
  StoryView(
      {super.key,
      required this.storyImage,
      required this.username,
      required this.storyOwnerPic});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                child: (widget.storyImage != '')
                    ? Image.network(
                        widget.storyImage.toString(),
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 17,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: (widget.storyOwnerPic != '')
                              ? Image.network(
                                  widget.storyOwnerPic.toString(),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(widget.username.toString()),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
