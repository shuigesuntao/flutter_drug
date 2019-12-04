

import 'package:flutter_drug/model/banner.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';
import 'package:flutter_drug/service/wan_android_repository.dart';
import 'package:flutter_drug/view_model/user_model.dart';

class HomeModel extends ViewStateRefreshListModel<Banner> {

  @override
  Future<List<Banner>> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 0), () {
      List<Banner> results = List();
      results.add(Banner('签到得万元红包奖励','http://app.zgzydb.com/upload/adv/ad_1911300946209077820.png','https://wx.zgzydb.com/web4/decemberAct/#/?uid=0&edType=1'));
      results.add(Banner('大数据与人工智能基地','http://app.zgzydb.com/upload/adv/ad_1911251011409742885.png','https://app.zgzydb.com/web/423instruction/index.html?uid=0&edType=1'));
      return results;
    });
  }
}
