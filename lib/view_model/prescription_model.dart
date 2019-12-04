
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/prescription.dart';
import 'package:flutter_drug/model/prescription_formwork.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';


class PrescriptionListModel extends ViewStateRefreshListModel<Prescription> {
  final int status;

  PrescriptionListModel(this.status);

  List<Prescription> _filterList = [];

  List<Prescription> get filterList => _filterList;

  @override
  Future<List<Prescription>> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 1), () {
      List<Prescription> results = List();
      results.add(Prescription(1,"未支付","杨","男","18686868686",31,"阴虚;气郁;气郁;气郁;气郁;气郁;气郁;气郁",275.19,"2019-08-30 14:48:06"));
      results.add(Prescription(1,"未支付","杨","男","18686868686",31,"阴虚;痰湿;气郁;血瘀;气虚;湿热",628.90,"2019-08-30 12:48:06"));
      results.add(Prescription(4,"已完成","david","男","18686868686",0,"上火",35.64,"2019-08-30 14:48:06"));
      if(status > 0){
        results = results.where((p) => p.status == status).toList();
      }
      if(pageNum > 0){
        results.clear();
      }

      return results;
    });
  }


  remove(Object object){
    list.remove(object);
    notifyListeners();
  }

  filterData(String query){
    _filterList.clear();
    if(query.isNotEmpty){
      _filterList.addAll(list.where((p) => p.name.contains(query.toLowerCase()) || p.phone.contains(query.toLowerCase())));
    }
    if (_filterList.isEmpty && query.isNotEmpty) {
      setEmpty();
    } else {
      setIdle();
    }
    notifyListeners();
  }
}


class PrescriptionFormWorkListModel extends ViewStateRefreshListModel<PrescriptionFormWork> {
  final int status;

  PrescriptionFormWorkListModel(this.status);

  List<PrescriptionFormWork> _filterList = [];

  List<PrescriptionFormWork> get filterList => _filterList;

  @override
  Future<List<PrescriptionFormWork>> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 1), () {
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
      results.add(PrescriptionFormWork(1,1,"超量配伍禁忌测试",[Drug('制草乌',12),Drug('川乌',12),Drug('川贝母',12)]));
      results.add(PrescriptionFormWork(2,1,"跌打损伤",List<Drug>()..add(Drug('当归',10))));
      results.add(PrescriptionFormWork(3,1,"祛湿",drugs));

      results.add(PrescriptionFormWork(4,2,"清胆利湿汤",drugs));
      results.add(PrescriptionFormWork(5,2,"鸡苏散",drugs));
      results.add(PrescriptionFormWork(6,2,"二甲复脉汤",drugs));
      results.add(PrescriptionFormWork(7,2,"柿蒂散",drugs));
      results.add(PrescriptionFormWork(8,2,"生姜泻心汤",drugs));
      results.add(PrescriptionFormWork(9,2,"归芍六君子汤",drugs));
      //经方模板
      if(status > 0){
        results = results.where((p) => p.status == status).toList();
      }
      if(pageNum > 0){
        results.clear();
      }
      return results;
    });
  }

  filterData(String query){
    _filterList.clear();
    if(query.isNotEmpty){
      _filterList.addAll(list.where((p) => p.name.contains(query.toLowerCase())));
    }
    if (_filterList.isEmpty && query.isNotEmpty) {
      setEmpty();
    } else {
      setIdle();
    }
    notifyListeners();
  }
}