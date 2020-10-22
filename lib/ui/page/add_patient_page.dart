import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' as P;
import 'package:qr_flutter/qr_flutter.dart';

class AddPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = P.Provider.of<UserModel>(context,listen: false);
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(
        context,
        '二维码名片',
      ),
      body: SafeArea(child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(10),ScreenUtil().setWidth(15),ScreenUtil().setWidth(10)),
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(ImageHelper.wrapAssets('bg_qrcode_mingpian.png'),fit: BoxFit.fill,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(75),ScreenUtil().setWidth(50),ScreenUtil().setWidth(75),0),
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userModel.user.icon,
                    fit: BoxFit.fill,
                    width: ScreenUtil().setWidth(55),
                    height: ScreenUtil().setWidth(55),
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Text(
                  userModel.user.name,
                  style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Text(
                  '${userModel.user.type} | ${userModel.user.level}',
                  style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.grey),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                SizedBox(height:ScreenUtil().setWidth(10)),
                Text(
                  '在家随时随地找我',
                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                ),
                Text(
                  '复诊调方',
                  style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32), letterSpacing: 2),
                ),
                QrImage(
                  data: userModel.user.id.toString(),
                  version: QrVersions.auto,
                  size: ScreenUtil().setWidth(130),
                ),
                SizedBox(height: ScreenUtil().setWidth(5)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                RichText(
                  text: TextSpan(
                    text: '患者端扫描上方我的二维码',
                    style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(12)),
                    children: <TextSpan>[
                      TextSpan(
                        text: '即可随时与我沟通，在家找我复诊调方',
                        style: TextStyle(fontSize: ScreenUtil().setSp(12),color:  Colors.black),
                      )
                    ]),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  '或通过以下方式分享',
                  style: TextStyle(fontSize: ScreenUtil().setSp(16),color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(ImageHelper.wrapAssets('icon_weixin.png'),width: ScreenUtil().setWidth(45),height: ScreenUtil().setWidth(45)),
                    SizedBox(width: ScreenUtil().setWidth(65)),
                    Image.asset(ImageHelper.wrapAssets('icon_pengyouquan.png'),width: ScreenUtil().setWidth(45),height: ScreenUtil().setWidth(45))
                  ],
                )
              ],
            ),
          )
        ],
      ),bottom: true)
    );
  }
}
