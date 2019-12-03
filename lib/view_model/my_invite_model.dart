import 'package:flutter_drug/model/my_invite.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class MyInviteModel extends ViewStateRefreshListModel<MyInvite>{
  @override
  Future<List<MyInvite>> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds: 1), () {
      List<MyInvite> results = List();
      results.add(MyInvite("宋月来","",0,0,"男","15234525056","2019-10-09 20:32:26"));
      results.add(MyInvite("许洪亮","",1,1,"男","15234525056","2019-10-09 20:32:26"));
      results.add(MyInvite("鲁智深","",1,0,"男","15234525056","2019-10-09 20:32:26"));
      if(pageNum > 0){
        results.clear();
      }
      return results;
    });
  }

}