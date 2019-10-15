import 'package:flutter_drug/model/open_recipe_req.dart';
import 'package:flutter_drug/provider/view_state_model.dart';

class OpenRecipeViewModel extends ViewStateModel{
  OpenRecipeReq _req = OpenRecipeReq(drugs: []);

  OpenRecipeReq get req => _req;

  bool isShowPriceDetail = false;


  submit(OpenRecipeReq req){
    _req = req;
    notifyListeners();
  }

  toggleShow(){
    isShowPriceDetail = !isShowPriceDetail;
    notifyListeners();
  }
}