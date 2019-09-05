import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/prescription.dart';
import 'package:flutter_drug/model/prescription_formwork.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';


class PrescriptionListModel extends ViewStateRefreshListModel {
  final int status;

  PrescriptionListModel(this.status);

  @override
  Future<List> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 2), () {
      List<Prescription> results = List();
      results.add(Prescription(1,"未支付","杨","男",31,"[辩证]阴虚;气郁;气郁;气郁;气郁;气郁;气郁;气郁","2019-08-30 14:48:06"));
      results.add(Prescription(1,"未支付","杨","男",31,"[辩证]阴虚;痰湿;气郁;血瘀;气虚;湿热","2019-08-30 12:48:06"));
      results.add(Prescription(4,"已完成","david","男",0,"[辩证]上火","2019-08-30 14:48:06"));
      if(status > 0){
        results = results.where((p) => p.status == status).toList();
      }
      if(pageNum > 0){
        results.clear();
      }
      return results;
    });
  }


  remove(int index){
    list.removeAt(index);
    notifyListeners();
  }
}


class PrescriptionFormWorkListModel extends ViewStateRefreshListModel {
  final int status;

  PrescriptionFormWorkListModel(this.status);

  @override
  Future<List> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 2), () {
      List<PrescriptionFormWork> results = List();
      List<Drug> drugs = List();
      drugs.add(Drug('柴胡',12));
      drugs.add(Drug('黄岑',10));
      drugs.add(Drug('法半夏',9));
      drugs.add(Drug('木香',9));
      drugs.add(Drug('郁金',9));
      drugs.add(Drug('川木通',9));
      drugs.add(Drug('生栀子',10));
      drugs.add(Drug('茵陈',15));
      drugs.add(Drug('土大黄',10));
      drugs.add(Drug('车前子',12));
      //常用处方
      results.add(PrescriptionFormWork(1,"去火",drugs));
      results.add(PrescriptionFormWork(1,"跌打损伤",List<Drug>()..add(Drug('当归',10))));
      results.add(PrescriptionFormWork(1,"祛湿",drugs));

      results.add(PrescriptionFormWork(2,"清胆利湿汤",drugs));
      results.add(PrescriptionFormWork(2,"鸡苏散",drugs));
      results.add(PrescriptionFormWork(2,"二甲复脉汤",drugs));
      results.add(PrescriptionFormWork(2,"柿蒂散",drugs));
      results.add(PrescriptionFormWork(2,"生姜泻心汤",drugs));
      results.add(PrescriptionFormWork(2,"归芍六君子汤",drugs));
      //经方模板
      results = results.where((p) => p.status == status).toList();
      if(pageNum > 0 && status == 1){
        results.clear();
      }
      return results;
    });
  }
}