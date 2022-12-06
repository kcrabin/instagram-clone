import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/authentication/register/register.dart';

final postRef = FirebaseFirestore.instance.collection('post');

class CommentPage extends StatefulWidget {
  String postid = '';
  String username = '';
  String postCaption = '';
  String email = '';
  CommentPage({
    super.key,
    required this.postCaption,
    required this.email,
    required this.username,
    required this.postid,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  String profilePic = '';
  @override
  void initState() {
    print(widget.postid);
    try {
      Stream<QuerySnapshot> user =
          userRef.where('email', isEqualTo: widget.email).snapshots();
      user.forEach((field) {
        field.docs.asMap().forEach((index, data) {
          setState(() {
            profilePic = field.docs[index]['profilepic'];
            // print('print from coment page');
            // print(profilePic);
          });
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Comments',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/share.png',
                  height: 20,
                )),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: (profilePic != '')
                      ? Image.network(profilePic)
                      : Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 5),
                    ),
                    TextSpan(text: widget.postCaption),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('post').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  List comments = [];
                  final allPosts = snapshot.data?.docs;

                  for (var post in allPosts!) {
                    if (post.id == widget.postid) {
                      comments = post['comment'];
                      // print('posy ${post.id}');
                      // print('cozy${widget.postid}');
                      // print(widget.postid);
                    }
                  }

                  print(comments);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(36),
                              child: (comments[index]['commentorProfile'] != '')
                                  ? Image.network(
                                      comments[index]['commentorProfile'])
                                  : Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: comments[index]['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 5),
                                ),
                                TextSpan(text: comments[index]['comment']),
                              ],
                            ),
                          ),
                        );
                      }));
                })
          ],
        ),
      ),
    );
  }
}
