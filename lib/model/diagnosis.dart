import 'package:flutter_drug/model/drug.dart';

class Diagnosis {
  int id;
  String diagnosis;
  List<Drug> drugs;
  String time;

  Diagnosis(this.id,this.diagnosis,this.drugs,this.time);
}