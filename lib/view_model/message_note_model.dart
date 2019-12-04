

import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class MessageNoteModel extends ViewStateRefreshListModel{
  @override
  Future<List> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 0), () {
      List results = List();
      return results;
    });
  }

}