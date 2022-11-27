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
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.25),
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
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
            height: 35,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Padding(
                padding: EdgeInsets.all(3),
                child: Icon(
                  Icons.person_add_outlined, size: 20,
                  // color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
