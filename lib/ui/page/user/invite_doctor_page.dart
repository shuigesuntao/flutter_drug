

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InviteDoctorPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '邀请医生',actionText: '我的邀请',onActionPress: ()=>
        Navigator.of(context).pushNamed(RouteName.myInvite)
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(ImageHelper.wrapAssets('bj_yqys.png'))
          )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(15)),
            Image.asset(ImageHelper.wrapAssets('yaoqingyouli.png'),width: 120,height: 30),
            SizedBox(height: ScreenUtil().setHeight(15)),
            Text('每成功邀请1位医生好友且认证成功\n您和好友各获得49元现金奖励',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15)),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              width: 15,
              height: 4,
              color: Colors.white,
            ),
            SizedBox(height:ScreenUtil().setHeight(20)),
            Container(
              width: ScreenUtil().setWidth(280),
              height:  ScreenUtil().setHeight(440),
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(48+ScreenUtil.statusBarHeight)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageHelper.wrapAssets('iphone_null.png')))
              ),
              child: Column(
                children: <Widget>[
                  Text('单次开方药费\n满200元以上，可申请提现',textAlign:TextAlign.center,style: TextStyle(fontSize: 13)),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  QrImage(
                    data: "awdawe412312e12dqaqwsdawd",
                    version: QrVersions.auto,
                    size: ScreenUtil().setWidth(160),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  Text('面对面扫一扫\n或通过以下方式分享',textAlign:TextAlign.center,style: TextStyle(color: Theme.of(context).primaryColor)),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(ImageHelper.wrapAssets('icon_weixin.png'),width: 40,height: 40),
                      SizedBox(width: 40),
                      Image.asset(ImageHelper.wrapAssets('icon_pengyouquan.png'),width: 40,height: 40)
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