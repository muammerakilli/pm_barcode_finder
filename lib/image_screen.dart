import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:storage_path/storage_path.dart';
import './class/file_model.dart';
import './class/picture_name.dart';



void main() => runApp(PictureScreen());

class PictureScreen extends StatefulWidget {

  final PictureName pc;
  PictureScreen({Key key, @required this.pc}) : super(key: key);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  Future<void> getImagesPath() async {
    String imagespath = "";
    try {
      imagespath = await StoragePath.imagesPath;
      var response = jsonDecode(imagespath);
      print(response);
      var imageList = response as List;
      List<FileModel> list =
      imageList.map<FileModel>((json) => FileModel.fromJson(json)).toList();

      setState(() {
        if(widget.pc.picture_name!='Unknown' || widget.pc.picture_name!='-1') {
          //print(list.length.toString());
          for (int i = 0; i < list.length; i++) {
            print(list[i].files.length.toString());
            for (int j = 0; j < list[i].files.length; j++) {
              if (list[i].files[j].contains(widget.pc.picture_name)) {
                imagePath = list[i].files[j];
                break;
              }
            }
          }
        }
      });
    } on PlatformException {
      imagespath = 'Failed to get path';
    }

    return imagespath;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Picture'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            color: Colors.grey,
            width: double.maxFinite,
            height: double.maxFinite,
            child: imagePath != ""
                ? Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            )
                : Image.asset('images/icon_not_found.png'),
          ),
        ),
      ),
    );
  }
}