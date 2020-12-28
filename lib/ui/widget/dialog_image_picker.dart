import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogImagePicker extends StatelessWidget {
  final ValueChanged<File> onImageSelected;

  DialogImagePicker({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: ()=> Navigator.pop(context),
        child: Text('取消')
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: ()=> _selectImage(context, false),
          child: Text('从相册选取')
        ),
        CupertinoActionSheetAction(
          onPressed: ()=> _selectImage(context, true),
          child: Text('拍照')
        )
      ],
    );
  }

  void _selectImage(BuildContext context, bool isCamera) async {
    Navigator.pop(context);
    if (onImageSelected != null) {
      onImageSelected(await ImagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery));
    }
  }
}
