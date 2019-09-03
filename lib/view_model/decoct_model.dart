import 'package:flutter_drug/model/decoct_method.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class DecoctModel extends ViewStateRefreshListModel {
  List<DecoctMethod> _decoctMethods;

  List<DecoctMethod> get decoctMethods => _decoctMethods;

  @override
  Future<List> loadData({int pageNum}) async {
    List<DecoctMethod> results = List();
    return await Future.delayed(Duration(seconds: 2), () {
      results.add(DecoctMethod(1, "合药冲服"));
      results.add(DecoctMethod(2, "生汁兑入"));
      results.add(DecoctMethod(3, "溶化"));
      results.add(DecoctMethod(4, "煎汤代水"));
      results.add(DecoctMethod(5, "烊化"));
      results.add(DecoctMethod(6, "另煎"));
      results.add(DecoctMethod(7, "包煎"));
      results.add(DecoctMethod(8, "后下"));
      results.add(DecoctMethod(9, "先煎"));
      _decoctMethods = results;
      return results;
    });
  }
}