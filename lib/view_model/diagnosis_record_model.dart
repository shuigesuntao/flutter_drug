
import 'package:flutter_drug/model/diagnosis.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class DiagnosisRecordModel extends ViewStateRefreshListModel<Diagnosis>{
  @override
  Future<List<Diagnosis>> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds: 1), () {
      List<Diagnosis> results = List();
      results.add(Diagnosis(1, "头疼",[Drug('滑石粉',18),Drug('生甘草',30),Drug('薄荷',9)],'2019-10-09'));
      results.add(Diagnosis(2, "阴虚;气郁;气郁;气郁;气郁;气郁;气郁;气郁;",[Drug('滑石粉',18),Drug('生甘草',30),Drug('薄荷',9)],'2019-08-30'));
      results.add(Diagnosis(3, "阴虚;痰湿;气郁;血瘀;气虚;湿热;",[Drug('党参',12),Drug('麸炒白术',9),Drug('茯苓',9),Drug('炙甘草',5),Drug('陈皮',3),Drug('法半夏',3),Drug('生姜',3),Drug('大枣',1,unit: '枚(约10克)'),Drug('当归',9),Drug('白芍',9)],'2019-08-29'));
      return results;
    });
  }

}