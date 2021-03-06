

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String job;
  final bool hasRightIcon;
  final bool isLogin;
  final VoidCallback onButtonClick;
  UserInfoHeader({
    this.imageUrl,
    this.name,
    this.type,
    this.job,
    this.hasRightIcon = true,
    this.isLogin = true,
    this.onButtonClick});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipOval(
          child: CachedNetworkImage(
            width: ScreenUtil().setWidth(45),
            height: ScreenUtil().setWidth(45),
            imageUrl: imageUrl??'',
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => Image.asset(ImageHelper.wrapAssets('yishengtouxiang.png'), width: ScreenUtil().setWidth(45), height: ScreenUtil().setWidth(45)),
          )
        ),
        SizedBox(width: ScreenUtil().setWidth(10)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isLogin ? name : '您的个人工作室',
                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
              ),
              Text(
                isLogin ? '$type | $job' : '登录体验更多功能',
                style: TextStyle(color: Colors.grey[600], fontSize: ScreenUtil().setSp(12)),
              )
            ],
          )
        ),
        Offstage(
          offstage: !hasRightIcon,
          child: Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 8,height: 16),
        ),
        Offstage(
          offstage: hasRightIcon,
          child: GestureDetector(
            onTap: onButtonClick,
            child: Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8),ScreenUtil().setWidth(3),ScreenUtil().setWidth(8),ScreenUtil().setWidth(3)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).primaryColor, width: 1),
              ),
              child: Row(
                children: <Widget>[
                  Offstage(
                    offstage: !isLogin,
                    child: Padding(padding: EdgeInsets.only(right: ScreenUtil().setWidth(5)),child: Image.asset(ImageHelper.wrapAssets('icon_phone.png'),width: ScreenUtil().setWidth(11),height: ScreenUtil().setWidth(11))),
                  ),
                  Text(isLogin ? '平台客服' : '点击登录',style: TextStyle(color: Theme.of(context).primaryColor,fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(12)))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}