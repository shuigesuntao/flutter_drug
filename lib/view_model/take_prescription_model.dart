

import 'dart:io';

import 'package:flutter_drug/provider/view_state_model.dart';

class TakePrescriptionModel extends ViewStateModel{
  File _image;
  File get image => _image;

  set image(File file){
    _image = file;
    notifyListeners();
  }
}
