import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: _storedImage != null
            ? Image.file(
                _storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text(
                'No Image Taken!',
                textAlign: TextAlign.center,
              ),
        alignment: Alignment.center,
      ),
      const SizedBox(width: 10),
      Expanded(
        child: FlatButton.icon(
          label: Text('Take picture'),
          icon: Icon(Icons.camera),
          textColor: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ),
    ]);
  }
}
