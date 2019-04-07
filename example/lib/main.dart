import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:last_qr_scanner/last_qr_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = ""; 
  var controller;

  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    final channel = controller.channel;
    controller.init(qrKey);
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onRecognizeQR":
          dynamic arguments = call.arguments;
          setState(() {
            qrText = arguments.toString();
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Barcode Scanner Example'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: LastQrScannerPreview(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
              flex: 4,
            ),
            Expanded(
              child: Text("This is the result of scan: $qrText"),
              flex: 1,
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  this.controller.ToggleTorch();                  
                },
                child: Text("Toggle Torch"),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
