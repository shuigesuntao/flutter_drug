

import 'package:flutter_drug/model/check_message.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class CheckMessageModel extends ViewStateRefreshListModel<CheckMessage>{
  @override
  Future<List<CheckMessage>> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds: 2), () {
      List<CheckMessage> results = List();
      results.add(CheckMessage("[拍照]处方照片","审核中","药房人员正在加紧处理...","2019-08-30 12:32:43"));
      return results;
    });
  }

}