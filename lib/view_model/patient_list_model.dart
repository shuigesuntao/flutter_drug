

import 'package:flutter_drug/provider/view_state_list_model.dart';

class PatientListModel extends ViewStateListModel{
  final int status;

  PatientListModel(this.status);

  @override
  Future<List> loadData() async{
    return await Future.delayed(Duration(seconds: 0), () {
      List results = List();
      return results;
    });
  }

}