import 'package:flutter/material.dart';

import 'QR_helper.dart';
import 'image_input.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Barcode Scanner Example'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: new Center(
          child: new Column(
            children: <Widget>[
              QrScanner(),
              QrGenarator(),
              ImageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
