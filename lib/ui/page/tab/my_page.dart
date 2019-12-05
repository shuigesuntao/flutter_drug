import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/me_header.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
      appBar: TitleBar.buildCommonAppBar(context, '我的',
          isShowBack: false,
          actionText: '设置',
          actionTextColor: Colors.black87,
          onActionPress: () =>
              Navigator.of(context).pushNamed(RouteName.setting)),
      body: UserListWidget(),
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
          Consumer<UserModel>(
              builder: (context, model, child) => InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(RouteName.userInfo),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(20,10,20,10),
                      margin: EdgeInsets.symmetric(vertical:5),
                      child: UserInfoHeader(
                        imageUrl: model.user.icon,
                        name: model.user.name,
                        type: model.user.type,
                        job: model.user.level),
                    )
                  )),
          MeCell('我的账户', 'icon_zhanghu.png', onTap:()=>Navigator.of(context).pushNamed(RouteName.myAccount)),
          SizedBox(height: 5),
          MeCell('资质认证', 'icon_zizhi.png', auth:'已认证',onTap:()=>Navigator.of(context).pushNamed(RouteName.auth)),
          Divider(indent: 30,height: 0.5,color: Colors.grey[300]),
          MeCell('煎法管理', 'icon_jianfa.png',onTap:()=>Navigator.of(context).pushNamed(RouteName.decoct)),
          Divider(indent: 30,height: 0.5,color: Colors.grey[300]),
          MeCell('常用医嘱', 'icon_yizhu.png', onTap:()=>Navigator.of(context).pushNamed(RouteName.doctorAdvice)),
          SizedBox(height: 5),
          MeCell('地址管理', 'icon_dizhi.png', onTap:()=>Navigator.of(context).pushNamed(RouteName.addressManage,arguments: false)),
          Divider(indent: 30,height: 0.5,color: Colors.grey[300]),
          MeCell('我的执业保障', 'icon_baozhang.png',onTap:()=>Navigator.of(context).pushNamed(RouteName.myOccupation)),
          Divider(indent: 30,height: 0.5,color: Colors.grey[300]),
          MeCell('联系客服', 'icon_kefu.png',content:'400-052-0120',onTap:()=>showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('400 052 0120'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text("取消"),
                    onPressed: () {
                      Navigator.maybePop(context);
                      print("取消");
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("呼叫"),
                    onPressed: () => callPhone('400 052 0120'),
                  ),
                ],
              );
            })
          ),
          Divider(indent: 30,height: 0.5,color: Colors.grey[300]),
          MeCell('意见反馈', 'icon_fankui.png',onTap:()=>Navigator.of(context).pushNamed(RouteName.suggestion))
        ],
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

class MeCell extends StatelessWidget {
  final String title;
  final String content;
  final String auth;
  final String image;
  final VoidCallback onTap;

  MeCell(this.title,this.image,{this.content='',this.auth = '',this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap:onTap,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(14),ScreenUtil().setWidth(20),ScreenUtil().setWidth(14)),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      ImageHelper.wrapAssets(image),
                      width: ScreenUtil().setWidth(20),
                      height: ScreenUtil().setWidth(20),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child:Text(title, style: TextStyle(fontSize: ScreenUtil().setSp(16)))),
                    Offstage(
                      offstage: content.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(content,style: TextStyle(color: Color(0xffe56068),fontSize: ScreenUtil().setSp(14)))
                      ),
                    ),
                    Offstage(
                      offstage: auth.isEmpty,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.fromLTRB(5,2,5,2),
                        decoration: BoxDecoration(
                          color: Color(0x1ae56068),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets('icon_yirenzheng.png'),width: ScreenUtil().setWidth(12),height: ScreenUtil().setWidth(12)),
                            SizedBox(width: 5),
                            Text(auth,style: TextStyle(color: Color(0xffe56068),fontSize: ScreenUtil().setSp(12))),
                          ],
                        ),
                      )
                    ),
                    Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 8,height: 16)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[200],
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
