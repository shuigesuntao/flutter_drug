
import 'package:flutter_drug/model/conversation.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';

class ConversationModel extends ViewStateListModel<Conversation>{

  @override
  Future<List<Conversation>> loadData() async{
    List<Conversation> results = List();
    results.add(Conversation("杨","男","","[问诊已结束]","昨天"));
    results.add(Conversation("陶喆","女","","[问诊已结束]","12:30"));
    results.add(Conversation("三七","男","https://c-ssl.duitang.com/uploads/item/201905/21/20190521071744_QdrJH.thumb.700_0.jpeg","[问诊已结束]","刚刚"));
    return results;
  }


}