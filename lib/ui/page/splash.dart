import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_config.dart';



/// 用于项目初始化之前显示的页面
class SplashImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,//背景色
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        ImageHelper.wrapAssets('splash_bg.jpg'),
      ),
    );
  }
}


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    countDown();
  }

  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, nextPage);
  }

  void nextPage() {
    Navigator.of(context).pushReplacementNamed(RouteName.tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          color: Colors.white,//背景色
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            ImageHelper.wrapAssets('splash_bg.jpg'),
          ),
        ),
      ),
    );
  }
}




