import 'package:flutter_drug/model/prescription.dart';
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
}