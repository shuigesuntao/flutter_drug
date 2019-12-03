import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_drug/model/address.dart';
import 'package:flutter_drug/model/doctor_advice.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/ui/page/about_page.dart';
import 'package:flutter_drug/ui/page/account/bind_wechat_page.dart';
import 'package:flutter_drug/ui/page/account/month_bill_page.dart';
import 'package:flutter_drug/ui/page/account/show_account_page.dart';
import 'package:flutter_drug/ui/page/account/wechat_cash_page.dart';
import 'package:flutter_drug/ui/page/add_patient_page.dart';
import 'package:flutter_drug/ui/page/prescription/check_message_page.dart';
import 'package:flutter_drug/ui/page/prescription/confirm_order_page.dart';
import 'package:flutter_drug/ui/page/prescription/edit_drug_page.dart';
import 'package:flutter_drug/ui/page/prescription/finish_order_detail_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_already_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_formwork_tab_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_choose_person_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_open_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_sample_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_single_drug_detail_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_take_page.dart';
import 'package:flutter_drug/ui/page/prescription/p_yizhu_page.dart';
import 'package:flutter_drug/ui/page/prescription/order_detail_page.dart';
import 'package:flutter_drug/ui/page/search/p_form_work_search_page.dart';
import 'package:flutter_drug/ui/page/search/p_person_search_page.dart';
import 'package:flutter_drug/ui/page/setting_page.dart';
import 'package:flutter_drug/ui/page/splash.dart';
import 'package:flutter_drug/ui/page/suggestion_page.dart';
import 'package:flutter_drug/ui/page/tab/tab_navigator.dart';
import 'package:flutter_drug/ui/page/test.dart';
import 'package:flutter_drug/ui/page/user/address_manager_page.dart';
import 'package:flutter_drug/ui/page/user/auth_page.dart';
import 'package:flutter_drug/ui/page/user/decoct_manage_page.dart';
import 'package:flutter_drug/ui/page/user/doctor_advice_page.dart';
import 'package:flutter_drug/ui/page/user/edit_address_page.dart';
import 'package:flutter_drug/ui/page/user/edit_doctor_advice_page.dart';
import 'package:flutter_drug/ui/page/account/my_account_page.dart';
import 'package:flutter_drug/ui/page/user/example_page.dart';
import 'package:flutter_drug/ui/page/user/friend_info_page.dart';
import 'package:flutter_drug/ui/page/user/invite_doctor_page.dart';
import 'package:flutter_drug/ui/page/user/my_invite_page.dart';
import 'package:flutter_drug/ui/page/user/my_occupation_page.dart';
import 'package:flutter_drug/ui/page/user/publish_notice_page.dart';
import 'package:flutter_drug/ui/page/user/service_setting_page.dart';
import 'package:flutter_drug/ui/page/user/user_info_page.dart';
import 'package:flutter_drug/ui/page/web_view_page.dart';
import 'package:flutter_drug/ui/widget/page_route_anim.dart';


class RouteName {
  static const String splash = 'splash';//闪屏页
  static const String tab = '/';//首页
  static const String test = 'test';//测试
  static const String addPatient = 'addPatient';//添加患者
  static const String inviteDoctor = 'inviteDoctor';//邀请医生
  static const String myInvite = 'MyInvite';//邀请医生
  static const String choosePerson = 'choosePerson';//选择开方患者
  static const String friendInfo = 'friendInfo';//患者信息
  static const String openPrescription = 'openPrescription';//在线开方
  static const String prescriptionYiZhu = 'prescriptionYiZhu';//开方医嘱
  static const String singleDrugPriceDetail = 'singleDrugPriceDetail';//单剂药品详情
  static const String takePrescription = 'takePrescription';//拍方上传
  static const String checkMessage = 'checkMessage';//审方消息
  static const String prescriptionFormWork = 'prescriptionFormWork';//处方模板
  static const String serviceSetting = 'serviceSetting';//服务设置
  static const String publishNotice = 'publishNotice';//发布公告
  static const String prescriptionAlready = 'prescriptionAlready';//已开处方
  static const String orderDetail = 'orderDetail';//已开处方详情
  static const String finishOrderDetail = 'finishOrderDetail';//已开处方详情(已完成)
  static const String confirmOrder = 'confirmOrder';//确认处方
  static const String prescriptionSample = 'prescriptionSample';//处方示例
  static const String prescriptionFormWorkSearch = 'prescriptionFormWorkSearch';//处方模板搜索
  static const String prescriptionPersonSearch = 'prescriptionPersonSearch';//开方患者搜索
  static const String login = 'login';
  static const String register = 'register';
  static const String myAccount = 'myAccount';//我的账户
  static const String webView = 'webView';//提现规则
  static const String weChatCash = 'weChatCash';//微信提现
  static const String bindWeChat = 'bindWeChat';//绑定微信
  static const String showAccount = 'showAccount';//查看账单
  static const String monthBill = 'monthBill';//查看账单
  static const String userInfo = 'userInfo';//我的名片
  static const String auth = 'auth';//资质认证
  static const String example = 'example';//认证示例
  static const String decoct = 'decoct';//煎法管理
  static const String doctorAdvice = 'doctorAdvice';//常用医嘱
  static const String editDoctorAdvice = 'editDoctorAdvice';//编辑医嘱
  static const String addressManage = 'addressManage';//地址管理
  static const String editAddress = 'editAddress';//编辑地址
  static const String myOccupation = 'myOccupation';//我的职业保障
  static const String suggestion = 'suggestion';//意见反馈
  static const String setting = 'setting';//设置
  static const String about = 'about';//关于
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
      case RouteName.inviteDoctor:
        return CupertinoPageRoute(builder: (_) => InviteDoctorPage());
      case RouteName.myInvite:
        return CupertinoPageRoute(builder: (_) => MyInvitePage());
      case RouteName.choosePerson:
        return CupertinoPageRoute(builder: (_) => PrescriptionChoosePersonPage());
      case RouteName.friendInfo:
        return CupertinoPageRoute(builder: (_) => FriendInfoPage(friend: settings.arguments as Friend));
      case RouteName.openPrescription:
        return CupertinoPageRoute(builder: (_) => PrescriptionOpenPage(friend: settings.arguments as Friend));
      case RouteName.prescriptionYiZhu:
        return CupertinoPageRoute(builder: (_) => PrescriptionYiZhuPage(text: settings.arguments as String));
      case RouteName.singleDrugPriceDetail:
        return CupertinoPageRoute(builder: (_) => SingeDrugDetailPage(drugs: settings.arguments as List));
      case RouteName.takePrescription:
        return CupertinoPageRoute(builder: (_) => TakePrescriptionPage());
      case RouteName.checkMessage:
        return CupertinoPageRoute(builder: (_) => CheckMessagePage());
      case RouteName.prescriptionFormWork:
        return CupertinoPageRoute(builder: (_) => PrescriptionFormWorkPage(hasHistory: settings.arguments as bool));
      case RouteName.serviceSetting:
        return CupertinoPageRoute(builder: (_) => ServiceSettingPage());
      case RouteName.publishNotice:
        return CupertinoPageRoute(builder: (_) => PublishNoticePage());
      case RouteName.prescriptionAlready:
        return CupertinoPageRoute(builder: (_) => PrescriptionAlreadyPage());
      case RouteName.orderDetail:
        return CupertinoPageRoute(builder: (_) => OrderDetailPage(count: settings.arguments as int));
      case RouteName.finishOrderDetail:
        return CupertinoPageRoute(builder: (_) => FinishOrderDetailPage());
      case RouteName.confirmOrder:
        return CupertinoPageRoute(builder: (_) => ConfirmOrderPage());
      case RouteName.prescriptionSample:
        return CupertinoPageRoute(builder: (_) => PrescriptionSamplePage());
      case RouteName.prescriptionFormWorkSearch:
        return CupertinoPageRoute(builder: (_) => PrescriptionFormWorkSearchPage());
      case RouteName.prescriptionPersonSearch:
        return CupertinoPageRoute(builder: (_) => PrescriptionPersonSearchPage(type: settings.arguments as int));
      case RouteName.test:
        return CupertinoPageRoute(builder: (_) => TestPage());
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
      case RouteName.webView:
        return CupertinoPageRoute(builder: (_) => WebViewPage(map: settings.arguments as Map));
      case RouteName.myAccount:
        return CupertinoPageRoute(builder: (_) => MyAccountPage());
      case RouteName.weChatCash:
        return CupertinoPageRoute(builder: (_) => WeChatCashPage());
      case RouteName.bindWeChat:
        return CupertinoPageRoute(builder: (_) => BindWeChatPage());
      case RouteName.showAccount:
        return CupertinoPageRoute(builder: (_) => ShowAccountPage());
      case RouteName.monthBill:
        return CupertinoPageRoute(builder: (_) => MonthBillPage());
      case RouteName.auth:
        return CupertinoPageRoute(builder: (_) => AuthPage());
      case RouteName.example:
        return CupertinoPageRoute(builder: (_) => ExamplePage());
      case RouteName.decoct:
        return CupertinoPageRoute(builder: (_) => DecoctManagePage());
      case RouteName.doctorAdvice:
        return CupertinoPageRoute(builder: (_) => DoctorAdvicePage());
      case RouteName.editDoctorAdvice:
        return CupertinoPageRoute(builder: (_) => EditDoctorAdvicePage(advice: settings.arguments as DoctorAdvice));
      case RouteName.addressManage:
        return CupertinoPageRoute(builder: (_) => AddressManagePage(isSelect:settings.arguments as bool));
      case RouteName.editAddress:
        return CupertinoPageRoute(builder: (_) => EditAddressPage(address: settings.arguments as Address));
      case RouteName.myOccupation:
        return CupertinoPageRoute(builder: (_) => MyOccupationPage());
      case RouteName.suggestion:
        return CupertinoPageRoute(builder: (_) => SuggestionPage());
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.about:
        return CupertinoPageRoute(builder: (_) => AboutPage());
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
