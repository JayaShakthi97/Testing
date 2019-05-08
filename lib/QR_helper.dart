import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QrGenarator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QrGenaratorState();
  }
}

class QrGenaratorState extends State<QrGenarator> {
  String _qrMessage = 'Hello';
  final TextEditingController _controller = TextEditingController();
  String _inputErrorText;

  void _onGenarate(String text) {
    setState(() {
      _qrMessage = text;
      _controller.clear();
    });
  }

  void _onError() {
    setState(() {
      _inputErrorText = 'Error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Your message',
              errorText: _inputErrorText,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: RaisedButton(
              onPressed: () => _onGenarate(_controller.text),
              child: Text('Genarate'),
            ),
          ),
          QrImage(
              data: _qrMessage,
              size: 250,
              onError: (ex) => _onError(),
            ),
        ],
      ),
    );
  }
}

class QrScanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return QrScannerState();
  }
}

class QrScannerState extends State<QrScanner>{
  String _qrCode = '';

  Future _onScan() async {
    try {
      String qrCode = await BarcodeScanner.scan();
      setState(() => this._qrCode = qrCode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._qrCode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this._qrCode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this._qrCode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this._qrCode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Scan'),
            onPressed: _onScan,
          ),
          Text(_qrCode),
        ],
      ),
    );
  }
}
