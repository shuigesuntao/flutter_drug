
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:azlistview/azlistview.dart';

class FriendModel extends ViewStateListModel<Friend>{
  String _suspensionTag = "";
  List<Friend> _filterList = [];

  List<Friend> get filterList => _filterList;

  String get suspensionTag => _suspensionTag;

  set suspensionTag (String tag){
    _suspensionTag = tag;
    notifyListeners();
  }

  @override
  Future<List<Friend>> loadData() async{
    return await Future.delayed(Duration(seconds: 2), () {
      List<Friend> results = List();
      results.add(Friend("","Tony","","女",68,'15234563456',0,1));
      results.add(Friend("","张仲景","","男",21,'15234563457',1,0));
      results.add(Friend("","孙思邈","","男",12,'15234563457',1,0));
      results.add(Friend("","张飞","","男",33,'15234563457',1,0));
      results.add(Friend("","李逵","","女",44,'15234563457',1,0));
      results.add(Friend("","程咬金","","女",55,'15234563457',1,0));
      results.add(Friend("","樊哙","","女",66,'15234563457',1,0));
      results.add(Friend("","李时珍","","男",77,'15234563457',1,0));
      results.add(Friend("","华佗","","男",88,'15234563457',1,0));
      results.add(Friend("","李刚","","男",99,'15234563457',1,0));
      results.add(Friend("","宇文成都","","女",3,'15234563457',1,0));
      results.add(Friend("陶喆","陶喆","","女",31,'15334563458',0,0));
      results.add(Friend("杨","杨过","","男",27,'15934563459',1,1));
      results = _sortedList(results);
      return results;
    });
  }

  List<Friend> _sortedList(List<Friend> list) {
    if (list == null || list.isEmpty) return null;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].displayName);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(list);
    suspensionTag = list[0].tagIndex;
    return list;
  }


  filterData(String query){
    _filterList.clear();
    if(query.isNotEmpty){
      _filterList.addAll(list.where((friend) => friend.displayName.contains(query.toLowerCase()) || friend.name.contains(query.toLowerCase())));
    }
    if (_filterList.isEmpty && query.isNotEmpty) {
      setEmpty();
    } else {
      setIdle();
    }
    notifyListeners();
  }
}