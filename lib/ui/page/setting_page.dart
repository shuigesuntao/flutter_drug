
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

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
          _buildItem(context,'修改登录密码',RouteName.test),
          _buildItem(context,'修改绑定手机',RouteName.test),
          SizedBox(height: 5),
          _buildItem(context,'关于药匣子',RouteName.about),
          SizedBox(height: 50),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: FlatButton(
              onPressed: ()=> print('退出登录'),
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Text(
                '退出登录',
                style: TextStyle(fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
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
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
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
                indent: 30,
              ),
            ],
          ),
        ),
      )
    );
  }

}