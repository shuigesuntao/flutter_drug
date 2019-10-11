import 'package:flutter_drug/model/bill.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class BillModel extends ViewStateRefreshListModel<Bill>{
  double _totalIn = 0;
  double get totalIn => _totalIn;
  double _totalOut = 0;
  double get totalOut => _totalOut;
  @override
  Future<List<Bill>> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds: 1), () {
      List<Bill> results = List();
      results.add(Bill(1,1,"推荐用户(宋月来)","2019-10-09",2));
      results.add(Bill(2,1,"推荐用户(杨)","2019-10-09",3));
      results.add(Bill(3,2,"吃饭","2019-10-09",4));
      return results;
    });
  }

  @override
  onCompleted(List data) {
    data.forEach((bill){
      if(bill.type == 1){
        _totalIn+=bill.price;
      }
      if(bill.type == 2){
        _totalOut+=bill.price;
      }
    });
    notifyListeners();
  }
}