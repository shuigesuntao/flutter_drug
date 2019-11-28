import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class ShareDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text('选择要分享到的平台',style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(child: Column(
                children: <Widget>[
                  Image.asset(ImageHelper.wrapAssets('umeng_socialize_wechat.png'),width: 60,height: 60),
                  SizedBox(height: 5),
                  Text('微信',style: TextStyle(fontSize: 16))
                ],
              )),
              Expanded(child: Column(
                children: <Widget>[
                  Image.asset(ImageHelper.wrapAssets('umeng_socialize_wxcircle.png'),width: 60,height: 60),
                  SizedBox(height: 5),
                  Text('朋友圈',style: TextStyle(fontSize: 16))
                ],
              ),)
            ],
          )
        ],
      ),
    );
  }

}