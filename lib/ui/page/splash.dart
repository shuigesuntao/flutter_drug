import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(RouteName.tab));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 375, height: 667);

    return Scaffold(
      body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  ImageHelper.wrapAssets('spl_bg.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.asset(
                  ImageHelper.wrapAssets('splash_bg.jpg'),
                ),
              )
            ],
          )),
    );
  }
}
