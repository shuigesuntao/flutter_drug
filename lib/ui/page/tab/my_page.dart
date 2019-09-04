import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_config.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/me_header.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(
        context,
        '我的',
        isShowBack: false,
        actionText: '设置',
        actionTextColor:Colors.black54,
        onActionPress: ()=>Navigator.of(context).pushNamed(RouteName.setting)
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            UserListWidget(),
            Container(
                alignment: Alignment(1.0, 0.08),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('400 052 0120'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("取消"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  print("取消");
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text("呼叫"),
                                onPressed: () {
                                  callPhone('400 052 0120');
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Image.asset(
                    ImageHelper.wrapAssets('contact_phone.png'),
                    width: 100,
                    height: 50,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void callPhone(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: ListView(
        children: <Widget>[
          ProviderWidget<UserModel>(
              model: UserModel(),
              builder: (context, model, child) => InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(RouteName.userInfo),
                  child: UserInfoHeader(
                      headerBg: 'bg_account.png',
                      imageUrl: 'http://img2.woyaogexing.com/2019/08/30/3c02345e50aa4fbbadce736ae72d9313!600x600.jpeg',
                      name: '许洪亮',
                      type: '内科',
                      job: '职业医师',
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0)
                  )
              )
          ),
          MeCell('我的账户', 'ic_zhanghu.png', RouteName.myAccount),
          MeCell('资质认证', 'ic_zizhi.png', RouteName.myAccount),
          MeCell('煎法管理', 'ic_jianfa.png', RouteName.decoct),
          MeCell('地址管理', 'ic_dizhi.png', RouteName.myAccount),
          MeCell('我的执业保障', 'ic_baozhang.png', RouteName.myAccount),
          MeCell('意见反馈', 'ic_fankui.png', RouteName.myAccount),
          MeCell('常用医嘱', 'ic_yizhu.png', RouteName.myAccount)
        ],
      ),
    );
  }
}

class MeCell extends StatelessWidget {
  final String title;
  final String image;
  final String routeName;

  MeCell(this.title, this.image, this.routeName);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(routeName),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      ImageHelper.wrapAssets(image),
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                indent: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
