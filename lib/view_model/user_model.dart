

import 'package:flutter_drug/model/user.dart';
import 'package:flutter_drug/provider/view_state_model.dart';

class UserModel extends ViewStateModel {
  User _user;

  User get user => _user;

  bool get hasUser => user != null;
}