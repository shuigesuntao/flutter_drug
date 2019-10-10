import 'package:flutter_drug/model/law_news.dart';
import 'package:flutter_drug/provider/view_state_refresh_list_model.dart';

class LawNewsModel extends ViewStateRefreshListModel<LawNews>{
  @override
  Future<List<LawNews>> loadData({int pageNum}) async{
    return await Future.delayed(Duration(seconds: 2), () {
      List<LawNews> results = List();
      results.add(LawNews(1,"医疗过错的赔偿计算标准是什么？","使用《民法通则》起赔偿计算标准如下：\n（一）医疗费：根据医疗机构出具的医药费、住院费、住院费、住院费、住院费"));
      results.add(LawNews(2,"医疗事故的赔偿计算标准是什么？","使用《民法通则》起赔偿计算标准如下：\n（一）医疗费：根据医疗机构出具的医药费、住院费、住院费、住院费、住院费"));
      results.add(LawNews(3,"医疗事故与医疗过错有谁来鉴定？","使用《民法通则》起赔偿计算标准如下：\n（一）医疗费：根据医疗机构出具的医药费、住院费、住院费、住院费、住院费"));
      if(pageNum > 0){
        results.clear();
      }
      return results;
    });
  }

}