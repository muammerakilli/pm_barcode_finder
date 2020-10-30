import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import './class/picture_name.dart';
import 'image_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pennmenn Picture Finder'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.orange),
                      ),
                      color: Colors.orange,
                      onPressed: () {
                        scanBarcodeNormal();
                      },
                      child: Text("Read Barcode",style:TextStyle(fontSize: 20),),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Picture Name",style:TextStyle(fontSize: 20),),
                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    'Text: $_scanBarcode\n',
                    style: TextStyle(fontSize: 20),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.orange),
                      ),
                      color: Colors.orange,
                      onPressed: () {
                        PictureName data = PictureName(_scanBarcode);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureScreen(pc: data)),
                        );
                      },
                      child: Text("Find Picture",style:TextStyle(fontSize: 20),),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
