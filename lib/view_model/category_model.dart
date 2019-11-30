

import 'package:flutter_drug/model/category.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';

class CategoryModel extends ViewStateListModel<Category>{

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;
  set selectedCategory(int i){
    _selectedCategory = i;
    notifyListeners();
  }

  int _selectedDrugStore = 0;
  int get selectedDrugStore => _selectedDrugStore;
  set selectedDrugStore(int i){
    _selectedDrugStore = i;
    notifyListeners();
  }

  int _currentCategory = 0;
  int get currentCategory => _currentCategory;
  set currentCategory(int i){
    _currentCategory = i;
    notifyListeners();
  }

  int _currentDrugStore = 0;
  int get currentDrugStore => _currentDrugStore;
  set currentDrugStore(int i){
    _currentDrugStore = i;
    notifyListeners();
  }

  @override
  Future<List<Category>> loadData() async{
    return await Future.delayed(Duration(seconds: 1), () {
      List<Category> results = List();
      results.add(Category(1,"汤剂","https://app.zgzydb.com/upload/rp-proctype-logo/tangji@3x.png",[
        DrugStore(1, "药匣子优选","免加工费", "18:00前处方，当天煎煮发货","https://wx.zgzydb.com/web4/yxzinformation/#/?name=special"),
        DrugStore(2, "药匣子严选","免加工费", "18:00前处方，当天煎煮发货","https://wx.zgzydb.com/web4/yxzinformation/#/?name=high"),
        DrugStore(3, "药匣子京选", "免加工费", "18:00前处方，当天煎煮发货","https://wx.zgzydb.com/web4/yxzinformation/#/?name=middle"),
        DrugStore(4, "盛实精标","免加工费", "16:00前处方，当天煎煮发货","https://wx.zgzydb.com/web4/yxzinformation/#/ssbc"),
      ]));
      results.add(Category(2,"颗粒剂","https://app.zgzydb.com/upload/rp-proctype-logo/keliji@3x.png",[
        DrugStore(5, "康仁堂","免加工费", "18:00前处方，当天发货","https://wx.zgzydb.com/web4/yxzinformation/#/krt"),
        DrugStore(6, "华润三九", "免加工费", "18:00前处方，当天发货","https://wx.zgzydb.com/web4/yxzinformation/#/hrsj"),
      ]));
      results.add(Category(3,"粉剂","https://app.zgzydb.com/upload/rp-proctype-logo/fenji@3x.png",[
        DrugStore(1, "药匣子优选", "20元/kg;不足1kg按1kg计算", "当天发货","https://wx.zgzydb.com/web4/yxzinformation/#/?name=special"),
        DrugStore(2, "药匣子严选", "20元/kg;不足1kg按1kg计算", "18:00前处方，当天发货","https://wx.zgzydb.com/web4/yxzinformation/#/?name=high"),
        DrugStore(4, "盛实精标", "20元/kg;不足1kg按1kg计算", "8:00前处方，当天发货","https://wx.zgzydb.com/web4/yxzinformation/#/ssbc")
      ]));
      results.add(Category(4,"膏方","https://app.zgzydb.com/upload/rp-proctype-logo/gaofang@3x.png",[
        DrugStore(5, "康仁堂", "300元/30付,不足30付安30付计算", "依剂量约2天左右完成","https://wx.zgzydb.com/web4/yxzinformation/#/krt"),
        DrugStore(6, "华润三九", "300/料", "依剂量约3天左右完成","https://wx.zgzydb.com/web4/yxzinformation/#/hrsj"),
      ]));
      results.add(Category(5,"胶囊","https://app.zgzydb.com/upload/rp-proctype-logo/jiaonang@3x.png",[
        DrugStore(1, "药匣子优选", "20元/kg;不足1kg按1kg计算", "依剂量约1-2天完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=special"),
        DrugStore(2, "药匣子严选", "20元/kg;不足1kg按1kg计算", "依剂量约1-2天完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=high"),
        DrugStore(4, "盛实精标", "200元/kg;不足1kg按1kg计算", "依剂量约1-2天完成","https://wx.zgzydb.com/web4/yxzinformation/#/ssbc"),
      ]));
      results.add(Category(6,"水丸","https://app.zgzydb.com/upload/rp-proctype-logo/shuiwan@3x.png",[
        DrugStore(1, "药匣子优选", "70元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=special"),
        DrugStore(2, "药匣子严选", "70元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=high"),
        DrugStore(3, "药匣子京选", "70元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=middle"),
        DrugStore(4, "盛实精标", "70元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/ssbc"),
      ]));
      results.add(Category(7,"水蜜丸","https://app.zgzydb.com/upload/rp-proctype-logo/shuimiwan@3x.png",[
        DrugStore(1, "药匣子优选", "80元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=special"),
        DrugStore(2, "药匣子优选", "80元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=high"),
        DrugStore(3, "药匣子京选", "80元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=middle"),
        DrugStore(4, "盛实精标", "80元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/ssbc"),
      ]));
      results.add(Category(8,"大蜜丸","https://app.zgzydb.com/upload/rp-proctype-logo/damiwan@3x.png",[
        DrugStore(1, "药匣子优选", "130元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=special"),
        DrugStore(2, "药匣子优选", "130元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=high"),
        DrugStore(3, "药匣子京选", "130元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/?name=middle"),
        DrugStore(4, "盛实精标", "130元/kg;不足1kg按1kg计算", "依剂量约7天内完成","https://wx.zgzydb.com/web4/yxzinformation/#/ssbc"),
      ]));
      return results;
    });
  }

}