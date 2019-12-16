import 'package:flutter_drug/model/simple_drug.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';

class SearchDrugsModel extends ViewStateListModel<SimpleDrug>{
  String _query = "";
  String get query => _query;


  @override
  Future<List<SimpleDrug>> loadData() async{
    return await Future.delayed(Duration(seconds: 0), () {
      List<SimpleDrug> results = List();
      if(_query.startsWith('W')){
        results.addAll([SimpleDrug("威灵仙",0.3810),SimpleDrug("乌药",0.1260),SimpleDrug("瓦松",0.0780),SimpleDrug("乌梅",0.3420),SimpleDrug("五倍子",0.0990),SimpleDrug("乌枣",0.0780),SimpleDrug("五加皮",0.1200),SimpleDrug("五指毛桃根",0.1200)]);
      }
      return results;
    });
  }


  queryDrug(String query){
    _query = query;
    refresh();
  }

  clearQuery(){
    _query = '';
    list.clear();
    notifyListeners();
  }
}