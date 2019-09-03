
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_config.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        title: Text('设置中心'),
      ),
      body: Column(
        children: <Widget>[
          Divider(height: 1),
          _buildItem(context,'修改登录密码',RouteName.test),
          _buildItem(context,'修改绑定手机',RouteName.test),
          SizedBox(height: 5),
          _buildItem(context,'关于药匣子',RouteName.test),
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