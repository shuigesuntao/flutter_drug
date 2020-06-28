import 'package:flutter_drug/model/doctor_advice.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class DoctorAdviceModel extends ViewStateRefreshListModel<DoctorAdvice>{
  @override
  Future<List<DoctorAdvice>> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 1), () {
      List<DoctorAdvice> results = List();
      results.add(DoctorAdvice(1, "忌辛辣，孕妇慎用",1,0,"2020-06-25"));
      results.add(DoctorAdvice(2, "少饮冷饮、少吃冰淇淋、少吃水果、少吃凉拌食物，少用冷水洗浴、少穿透薄衣服、少穿凉拖鞋、少吹电扇冷空调",0,0,"2020-06-26"));
      results.add(DoctorAdvice(3, "一日3次，饭后服用",0,0,"2020-06-26"));
      results.add(DoctorAdvice(4, "少开门窗入睡、少睡凉席、少露宿、避免淋雨、少穿湿衣服、少游泳、少接触玻璃铁器",0,0,"2020-06-26"));
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