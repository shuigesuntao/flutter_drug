import 'package:flutter_drug/model/doctor_advice.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class DoctorAdviceModel extends ViewStateRefreshListModel<DoctorAdvice>{
  @override
  Future<List<DoctorAdvice>> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 1), () {
      List<DoctorAdvice> results = List();
      results.add(DoctorAdvice(1, "合药冲服合药冲服合药冲服合药冲服合药冲服合药冲服合药冲服合药冲服合药冲服合药冲服",1,0,"2019-08-30"));
      results.add(DoctorAdvice(2, "生汁兑入生汁兑入生汁兑入生汁兑入生汁兑入",1,0,"2019-08-30"));
      return results;
    });
  }

  setTop(int index,int top){
    list[index].top = top;
    notifyListeners();
  }

  remove(int index){
    list.removeAt(index);
    notifyListeners();
  }
}