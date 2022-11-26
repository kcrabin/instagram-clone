import 'package:flutter/material.dart';

class ShowSearch extends StatefulWidget {
  const ShowSearch({super.key});

  @override
  State<ShowSearch> createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          height: 37,
          // height: 50,
          width: double.infinity,

          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('See All'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
