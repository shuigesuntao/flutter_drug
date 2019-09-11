
import 'package:flutter_drug/model/address.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class AddressModel extends ViewStateRefreshListModel{
  @override
  Future<List> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds: 1), () {
      List<Address> results = List();
      results.add(Address("薛成江","18311023519",1,"北京市朝阳区","八里庄住邦2000商务中心2号"));
      results.add(Address("薛成江","18311023519",0,"北京市朝阳区","里外里公寓2单元1002"));
      return results;
    });
  }

}