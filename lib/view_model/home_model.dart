

import 'package:flutter_drug/model/banner.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';
import 'package:flutter_drug/service/wan_android_repository.dart';
import 'package:flutter_drug/view_model/user_model.dart';

class HomeModel extends ViewStateRefreshListModel<Banner> {

  @override
  Future<List<Banner>> loadData({int pageNum}) async {
    return await Future.delayed(Duration(seconds: 0), () {
      List<Banner> results = List();
      results.add(Banner('同心战疫 医者光荣 感恩活动','https://app.zgzydb.com/upload/adv/ad_2004031009267732595.png','http://wx.zgzydb.com/web4/aprAct/#/?uid=0&edType=1'));
      results.add(Banner('新型肺炎预防1号方','https://app.zgzydb.com/upload/adv/ad_2002131858173781245.png','http://wx.zgzydb.com/web4/getPre/index.html?uid=0&edType=1'));
      results.add(Banner('大数据与人工智能基地','https://app.zgzydb.com/upload/adv/ad_1911251011409742885.png','https://app.zgzydb.com/web/423instruction/index.html?uid=0&edType=1'));
      return results;
    });
  }
}
