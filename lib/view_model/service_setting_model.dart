
import 'package:flutter_drug/provider/view_state_model.dart';

class ServiceSettingModel extends ViewStateModel{
  bool _isOpenAsk = true;
  bool _isHidePrice = true;
  int _onlineAskPrice = 0;
  int _afterAskPrice = 0;
  int _singleServicePrice = 0;

  bool get isOpenAsk => _isOpenAsk;
  bool get isHidePrice => _isHidePrice;
  int get onlineAskPrice => _onlineAskPrice;
  int get afterAskPrice => _afterAskPrice;
  int get singleServicePrice => _singleServicePrice;

  set isOpenAsk(bool isAsk) {
    _isOpenAsk = isAsk;
    notifyListeners();
  }

  set isHidePrice(bool isHide) {
    _isHidePrice = isHide;
    notifyListeners();
  }

  set onlineAskPrice(int value) {
    _onlineAskPrice = value;
    notifyListeners();
  }
  set afterAskPrice(int value) {
    _afterAskPrice = value;
    notifyListeners();
  }
  set singleServicePrice(int value) {
    _singleServicePrice = value;
    notifyListeners();
  }
}