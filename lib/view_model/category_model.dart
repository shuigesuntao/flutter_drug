

import 'package:flutter_drug/model/category.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';

class CategoryModel extends ViewStateListModel<Category>{

  int _currentCategory = 1;
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
      results.add(Category(1,"饮片(不加工)",[
        DrugStore(1, "药匣子优选", "免加工费", "17:00前处方，当天发货；17:00后处方，次日发货"),
        DrugStore(2, "盛实精标", "免加工费", "17:00前处方，当天发货；17:00后处方，次日发货"),
        DrugStore(3, "药匣子京选", "免加工费", "")
      ]));
      results.add(Category(2,"汤剂(代煎)",[
        DrugStore(1, "药匣子优选", "免加工费", "16:00前处方，当天煎煮发货；16:00后处方，次日煎煮发货"),
        DrugStore(2, "盛实精标", "免加工费", "16:00前处方，当天煎煮发货；16:00后处方，次日煎煮发货"),
        DrugStore(3, "药匣子京选", "免加工费", "")
      ]));
      results.add(Category(3,"颗粒剂",[
        DrugStore(4, "康仁堂", "免加工费", "17:00前处方，当天发货；17:00后处方，次日发货"),
        DrugStore(5, "华润三九", "免加工费", "17:00前处方，当天发货；17:00后处方，次日发货"),
      ]));
      results.add(Category(4,"粉剂",[
        DrugStore(1, "药匣子优选", "1kg内20元，每超出1千克加收20元", "17:00前处方，当天发货；17:00后处方，次日发货"),
        DrugStore(2, "盛实精标", "1kg内20元，每超出1千克加收20元", "17:00前处方，当天发货；17:00后处方，次日发货"),
        DrugStore(3, "药匣子京选", "1kg内20元，每超出1千克加收20元", "")
      ]));
      results.add(Category(5,"大蜜丸",[
        DrugStore(1, "药匣子优选", "1kg内130元，每超出1千克加收130元", "依剂量约7天内完成"),
        DrugStore(2, "盛实精标", "1kg内130元，每超出1千克加收130元", "依剂量约7天内完成"),
        DrugStore(3, "药匣子京选", "1kg内130元，每超出1千克加收130元", "")
      ]));
      results.add(Category(6,"胶囊",[
        DrugStore(1, "药匣子优选", "1kg内200元，每超出1千克加收200元", "纯手工制作，依剂量约1-2天完成"),
        DrugStore(2, "盛实精标", "1kg内200元，每超出1千克加收200元", "纯手工制作，约3-7天完成"),
      ]));
      results.add(Category(7,"水丸",[
        DrugStore(1, "药匣子优选", "1kg内70元，每超出1千克加收70元", "依剂量约7天内完成"),
        DrugStore(2, "盛实精标", "1kg内70元，每超出1千克加收70元", "依剂量约7天内完成"),
        DrugStore(3, "药匣子京选", "1kg内70元，每超出1千克加收70元", "")
      ]));
      results.add(Category(8,"水蜜丸",[
        DrugStore(1, "药匣子优选", "1kg内80元，每超出1千克加收80元", "依剂量约7天内完成"),
        DrugStore(2, "盛实精标", "1kg内80元，每超出1千克加收80元", "依剂量约7天内完成"),
        DrugStore(3, "药匣子京选", "1kg内780元，每超出1千克加收80元", "")
      ]));
      results.add(Category(9,"膏方",[
        DrugStore(4, "康仁堂", "10付起做，30付内300元，每超出30付加收300元", "依剂量约2天左右完成(蜂蜜、木糖醇)"),
        DrugStore(5, "华润三九", "300/料，10付起做", "依剂量约3天左右完成(蜂蜜、木糖醇)"),
      ]));
      return results;
    });
  }

}