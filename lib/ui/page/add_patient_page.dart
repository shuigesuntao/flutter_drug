import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(
        context,
        '二维码名片',
      ),
      body: SafeArea(child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15,10,15,10),
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(ImageHelper.wrapAssets('bg_qrcode_mingpian.png'),fit: BoxFit.fill,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(75,40,75,0),
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userModel.user.icon,
                    fit: BoxFit.fill,
                    width: 60,
                    height: 60,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  userModel.user.name,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  '${userModel.user.type} | ${userModel.user.level}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 15),
                Text(
                  '在家随时随地找我',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '复诊调方',
                  style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 32, letterSpacing: 2),
                ),
                QrImage(
                  data: userModel.user.id.toString(),
                  version: QrVersions.auto,
                  size: 140,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: '微信扫描上方我的二维码，关注',
                    style: TextStyle(color: Colors.black,fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: '「药匣子在线」',
                        style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor)),
                      TextSpan(
                        text: '公众号，即可随时微信与我沟通，在家找我复诊调方',
                        style: TextStyle(fontSize: 12,color:  Colors.black),
                      )
                    ]),
                ),
                SizedBox(height: 20),
                Text(
                  '或通过以下方式分享',
                  style: TextStyle(fontSize: 16,color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(ImageHelper.wrapAssets('icon_weixin.png'),width: 40,height: 40),
                    SizedBox(width: 60),
                    Image.asset(ImageHelper.wrapAssets('icon_pengyouquan.png'),width: 40,height: 40)
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
