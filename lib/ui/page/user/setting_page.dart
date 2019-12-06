
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(
        context,
        '设置中心',
      ),
      body: Column(
        children: <Widget>[
          Divider(height: 1),
          _buildItem(context,'修改登录密码',RouteName.modifyPassword),
          _buildItem(context,'修改绑定手机',RouteName.modifyPhone),
          SizedBox(height: ScreenUtil().setWidth(5)),
          _buildItem(context,'关于药匣子',RouteName.about),
          SizedBox(height: ScreenUtil().setWidth(50)),
          GestureDetector(
            onTap: () {
              Provider.of<UserModel>(context).clearUser();
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => route == null);
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child:Center(
                child: Text('退出登录', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title,String routeName) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(routeName),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(50),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),right: ScreenUtil().setWidth(20)),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(title, style: TextStyle(fontSize: ScreenUtil().setSp(16)))),
                    Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 7,height: 14)
                  ],
                ),
              ),
              Divider(
                height: 1,
                indent: ScreenUtil().setWidth(30),
              ),
            ],
          ),
        ),
      )
    );
  }

}