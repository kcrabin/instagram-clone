import 'package:flutter/material.dart';

class EditProfileContainer extends StatelessWidget {
  const EditProfileContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Padding(
                padding: EdgeInsets.all(3),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
