import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogImagePicker extends StatelessWidget {
  final ValueChanged<File> onImageSelected;

  DialogImagePicker({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(bottom:true,
      child: Container(
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => _selectImage(context, false),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('从相册选择',
                      style: TextStyle(
                        fontSize: 18, color: Colors.blue[800]))),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () => _selectImage(context, true),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('拍照',
                      style: TextStyle(
                        fontSize: 18, color: Colors.blue[800]))),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () => Navigator.maybePop(context),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text('取消',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold))),
            ),
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ],
      ),
    ));
  }

  void _selectImage(BuildContext context, bool isCamera) async {
    Navigator.maybePop(context);
    if (onImageSelected != null) {
      onImageSelected( await ImagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery));
    }
  }
}
