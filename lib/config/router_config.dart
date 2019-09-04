import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_drug/ui/page/add_patient_page.dart';
import 'package:flutter_drug/ui/page/prescription/check_message_page.dart';
import 'package:flutter_drug/ui/page/prescription/prescription_sample_page.dart';
import 'package:flutter_drug/ui/page/prescription/take_prescription_page.dart';
import 'package:flutter_drug/ui/page/setting_page.dart';
import 'package:flutter_drug/ui/page/splash.dart';
import 'package:flutter_drug/ui/page/tab/tab_navigator.dart';
import 'package:flutter_drug/ui/page/test.dart';
import 'package:flutter_drug/ui/page/user/decoct_manage_page.dart';
import 'package:flutter_drug/ui/page/user/my_account_page.dart';
import 'package:flutter_drug/ui/page/user/packet_rule_page.dart';
import 'package:flutter_drug/ui/page/user/publish_notice_page.dart';
import 'package:flutter_drug/ui/page/user/service_setting_page.dart';
import 'package:flutter_drug/ui/page/user/user_info_page.dart';
import 'package:flutter_drug/ui/widget/page_route_anim.dart';


class RouteName {
  static const String splash = 'splash';//闪屏页
  static const String tab = '/';//首页
  static const String test = 'test';//测试
  static const String addPatient = 'addPatient';//添加患者
  static const String takePrescription = 'takePrescription';//拍方上传
  static const String checkMessage = 'checkMessage';//审方消息
  static const String serviceSetting = 'serviceSetting';//服务设置
  static const String publishNotice = 'publishNotice';//发布公告
  static const String prescriptionSample = 'prescriptionSample';//处方示例
  static const String login = 'login';
  static const String register = 'register';
  static const String myAccount = 'myAccount';//我的账户
  static const String packetRule = 'packetRule';//提现规则
  static const String userInfo = 'userInfo';//我的名片
  static const String decoct = 'decoct';//煎法管理
  static const String setting = 'setting';//设置
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.addPatient:
        return CupertinoPageRoute(builder: (_) => AddPatientPage());
      case RouteName.takePrescription:
        return CupertinoPageRoute(builder: (_) => TakePrescriptionPage());
      case RouteName.checkMessage:
        return CupertinoPageRoute(builder: (_) => CheckMessagePage());
      case RouteName.serviceSetting:
        return CupertinoPageRoute(builder: (_) => ServiceSettingPage());
      case RouteName.publishNotice:
        return CupertinoPageRoute(builder: (_) => PublishNoticePage());
      case RouteName.prescriptionSample:
        return CupertinoPageRoute(builder: (_) => PrescriptionSamplePage());
      case RouteName.test:
        return CupertinoPageRoute(builder: (_) =>TestPage());
//      case RouteName.homeSecondFloor:
//        return SlideTopRouteBuilder(MyBlogPage());
//      case RouteName.login:
//        return CupertinoPageRoute(
//            fullscreenDialog: true, builder: (_) => LoginPage());
//      case RouteName.register:
//        return CupertinoPageRoute(builder: (_) => RegisterPage());
//      case RouteName.articleDetail:
//        var article = settings.arguments as Article;
//        return CupertinoPageRoute(builder: (_) {
//          // 根据配置调用页面
//          return StorageManager.sharedPreferences.getBool(kUseWebViewPlugin) ??
//                  false
//              ? ArticleDetailPluginPage(
//                  article: article,
//                )
//              : ArticleDetailPage(
//                  article: article,
//                );
//        });
//      case RouteName.structureList:
//        var list = settings.arguments as List;
//        Tree tree = list[0] as Tree;
//        int index = list[1];
//        return CupertinoPageRoute(
//            builder: (_) => ArticleCategoryTabPage(tree, index));
      case RouteName.packetRule:
        return CupertinoPageRoute(builder: (_) => PacketRulePage(url: settings.arguments as String));
      case RouteName.myAccount:
        return CupertinoPageRoute(builder: (_) => MyAccountPage());
      case RouteName.decoct:
        return CupertinoPageRoute(builder: (_) => DecoctManagePage());
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.userInfo:
        return CupertinoPageRoute(builder: (_) => UserInfoPage());
//      case RouteName.coinRankingList:
//        return CupertinoPageRoute(builder: (_) => CoinRankingListPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
