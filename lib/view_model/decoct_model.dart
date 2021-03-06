import 'package:flutter_drug/model/decoct_method.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class DecoctModel extends ViewStateRefreshListModel<DecoctMethod> {
  bool _isDelete = false;

  bool get isDelete => _isDelete;


  DecoctModel(){
    _isDelete = false;
  }

  @override
  Future<List<DecoctMethod>> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds:1), () {
      List<DecoctMethod> results = List();
      results.add(DecoctMethod(1, "合药冲服"));
      results.add(DecoctMethod(2, "生汁兑入"));
      results.add(DecoctMethod(3, "溶化"));
      results.add(DecoctMethod(4, "煎汤代水"));
      results.add(DecoctMethod(5, "烊化"));
      results.add(DecoctMethod(6, "另煎"));
      results.add(DecoctMethod(7, "包煎"));
      results.add(DecoctMethod(8, "后下"));
      results.add(DecoctMethod(9, "先煎"));
      return results;
    });
  }

  changeDeleteMode(){
    _isDelete = !isDelete;
    notifyListeners();
  }

  add(String name){
    list.insert(0,DecoctMethod(100,name));
    notifyListeners();
  }

  remove(int index){
    list.removeAt(index);
    notifyListeners();
  }
}
