import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pm_barcode_finder/image_screen.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //String _scanBarcode = 'sample.jpg';
  String _scanBarcode="" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "Pennmenn",
                style: GoogleFonts.getFont('Lato', fontSize: 32),
              ),
              Text(
                "QR Kod Resim Bulucu",
                style: GoogleFonts.getFont('Lato', fontSize: 24),
              ),
              SizedBox(
                height: 50,
              ),
              Image.asset("images/qr_code.png"),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  child: Text(
                    'Tara',
                    style: GoogleFonts.getFont('Lato', fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    scanBarcodeNormal();
                    if (_scanBarcode != "-1" && _scanBarcode.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PictureScreen(name: _scanBarcode)),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}
