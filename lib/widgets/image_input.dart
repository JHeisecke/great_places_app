import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final imagePicker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    File imageFile;
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      return;
    }

    setState(() {
      if (pickedFile != null) {
        _storedImage = imageFile;
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

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
          onPressed: _getImage,
        ),
      ),
    ]);
  }
}
