

import 'package:flutter_drug/model/drug.dart';

class PrescriptionFormWork{
  int id;
  int status; //1 常用处方 2 经方模板
  String name;
  List<Drug> drugs;

  PrescriptionFormWork(this.id,this.status,this.name,this.drugs);
}