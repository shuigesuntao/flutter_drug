

import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_drug/model/user.dart';
import 'package:flutter_drug/provider/view_state_model.dart';

class UserModel extends ViewStateModel {
  static const String kUser = 'kUser';

  User _user;

  User get user => _user;

  bool get hasUser => user != null;


  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromJsonMap(userMap) : User(1,"http://img2.woyaogexing.com/2019/08/30/3c02345e50aa4fbbadce736ae72d9313!600x600.jpeg","许洪亮","主任医师");
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}