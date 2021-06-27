import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_fonts/google_fonts.dart';

class PictureScreen extends StatefulWidget {
  final String name;
  PictureScreen({Key key, @required this.name}) : super(key: key);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  String imagePath = "";
  String downloadURL;
  bool isLoad = false;
  bool isFind = false;

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> getURL() async {
    try {
      downloadURL = await storage.ref('images/${widget.name}').getDownloadURL();
      setState(() {
        isLoad = isFind = true;
      });
    } catch (_) {
      setState(() {
        isLoad = true;
        isFind = false;
      });
    }
  }

  @override
  void initState() {
    getURL();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resim',
          style: GoogleFonts.getFont('Lato', fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: isLoad == true
                ? isFind == true
                    ? Image.network(
                        downloadURL,
                        fit: BoxFit.contain,
                      )
                    : Image.asset("images/icon_not_found.png")
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
