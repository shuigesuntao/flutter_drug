

import 'package:flutter_drug/model/check_message.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class CheckMessageModel extends ViewStateRefreshListModel{
  List<CheckMessage> _checkMessages;

  List<CheckMessage> get checkMessages => _checkMessages;

  @override
  Future<List> loadData({int pageNum}) async{
    List<CheckMessage> results = List();
    return await Future.delayed(Duration(seconds: 2), () {
      results.add(CheckMessage("[拍照]处方照片","审核中","药房人员正在加紧处理...","2019-08-30 12:32:43"));
      _checkMessages = results;
      return results;
    });
  }

}