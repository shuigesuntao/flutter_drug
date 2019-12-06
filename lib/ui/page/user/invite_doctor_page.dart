import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InviteDoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '邀请医生',
          actionText: '我的邀请',
          onActionPress: () =>
              Navigator.of(context).pushNamed(RouteName.myInvite)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(ImageHelper.wrapAssets('bj_yqys.png')))),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(30),
                    bottom: ScreenUtil().setWidth(20)),
                child: Image.asset(ImageHelper.wrapAssets('yaoqingyouli.png'),
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setWidth(30))),
            Text('每成功邀请1位医生好友且认证成功\n您和好友各获得49元现金奖励',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(15))),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
              child: Container(
                width: 15,
                height: 4,
                color: Colors.white,
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(300),
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(50)+ScreenUtil.statusBarHeight,bottom: ScreenUtil().setWidth(65) + ScreenUtil.bottomBarHeight),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                      image: AssetImage(
                          ImageHelper.wrapAssets('iphone_null.png')))),
              child: Column(
                children: <Widget>[
                  Text('单次开方药费\n满200元以上，可申请提现',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  QrImage(
                    data: "awdawe412312e12dqaqwsdawd",
                    padding: EdgeInsets.all(0),
                    version: QrVersions.auto,
                    size: ScreenUtil().setHeight(130),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Text('面对面扫一扫\n或通过以下方式分享',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14))),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(ImageHelper.wrapAssets('icon_weixin.png'),
                          width: ScreenUtil().setWidth(45),
                          height: ScreenUtil().setWidth(45)),
                      SizedBox(width: ScreenUtil().setWidth(40)),
                      Image.asset(
                          ImageHelper.wrapAssets('icon_pengyouquan.png'),
                          width: ScreenUtil().setWidth(45),
                          height: ScreenUtil().setWidth(45))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
