import 'package:flutter/material.dart';

class HighlightsView extends StatefulWidget {
  String? highlightsImage;

  HighlightsView({
    super.key,
    required this.highlightsImage,
  });

  @override
  State<HighlightsView> createState() => _HighlightsViewState();
}

class _HighlightsViewState extends State<HighlightsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ]),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: (widget.highlightsImage != '')
              ? Image.network(
                  widget.highlightsImage.toString(),
                  fit: BoxFit.cover,
                )
              : Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1280px-A_black_image.jpg',
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
