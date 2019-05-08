import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImagePickerState();
  }
}

class ImagePickerState extends State<ImageInput> {
  File _imageFile;

  void _getImage(ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((onValue) {
      setState(() {
        _imageFile = onValue;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Text('Pick an Image'),
                Row(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () => _getImage(ImageSource.camera),
                        child: Text('Camera')),
                    SizedBox(
                      width: 30,
                    ),
                    FlatButton(
                        onPressed: () => _getImage(ImageSource.gallery),
                        child: Text('Gallery')),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _openImagePicker,
            child: Text('Pick an Image'),
          ),
          _imageFile == null
              ? Text('No image selected')
              : Image.file(_imageFile),
        ],
      ),
    );
  }
}
