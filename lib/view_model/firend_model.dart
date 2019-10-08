
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
      results.add(Friend("","david","","",0,0,1));
      results.add(Friend("","eb9552162","","",0,1,0));
      results.add(Friend("陶喆","陶喆","","女",31,0,0));
      results.add(Friend("杨","杨过","","男",27,1,1));
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
      _filterList.addAll(list.where((friend) => friend.displayName.contains(query) || friend.name.contains(query)));
    }
    notifyListeners();
  }
}