import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildWidget> independentServices = [
//  Provider.value(value: Api())
  ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel(),
  ),
  ChangeNotifierProvider<FriendModel>(
    create: (context) => FriendModel(),
  )
];

/// 需要依赖的model
List<SingleChildWidget> dependentServices = [
//  ProxyProvider<Api, AuthenticationService>(
//    builder: (context, api, authenticationService) =>
// FriendModel       AuthenticationService(api: api),
//  )
];

List<SingleChildWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
