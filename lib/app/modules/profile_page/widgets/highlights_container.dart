import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/modules/add_page/add_highlights.dart';
import 'package:instagram_clone/app/modules/profile_page/widgets/highlights_view.dart';

import '../../authentication/register/register.dart';

class HighlightsContainer extends StatefulWidget {
  const HighlightsContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<HighlightsContainer> createState() => _HighlightsContainerState();
}

class _HighlightsContainerState extends State<HighlightsContainer> {
  final _firebaseStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  String email = '';

  File? image;
  final imagePicker = ImagePicker();
  String imageUrl = '';

  Future getImage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image == null) return;
    var file = File(image.path);
    String imageName = image.path.split('/').last;
    var snapshot = await _firebaseStorage
        .ref()
        .child('highlights/$imageName')
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      print(downloadUrl);
      imageUrl = downloadUrl;
    });
  }

  @override
  void initState() {
    try {
      String? uid = _auth.currentUser!.uid;

      userRef.doc(uid).get().then((DocumentSnapshot doc) {
        setState(() {
          email = doc['email'];

          print(email);
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 100,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('highlights')
                  .where('email', isEqualTo: email)
                  .snapshots(),
              builder: (context, snapshot) {
                final docs = snapshot.data?.docs;

                if (!snapshot.hasData) return new Text('Loading');
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = docs![index];
                      String highlights_email = data.get('email');
                      return highlights_email == email
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HighlightsView(
                                        highlightsImage: data.get('imagepath'),
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 36,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(36),
                                          child: (data.get('imagepath') != '')
                                              ? Image.network(
                                                  data.get('imagepath'),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Highlights'),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox();
                    });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 60,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await getImage(ImageSource.camera);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddHighlightsPage(imageUrl: imageUrl),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            await getImage(ImageSource.gallery);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddHighlightsPage(imageUrl: imageUrl),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.collections,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 34,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 33,
                      child: ClipOval(
                          clipBehavior: Clip.hardEdge,
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Text('New'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
