import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BindWeChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '绑定微信',actionText: '解绑',onActionPress: (){
        print('点击了解绑');
      }),
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setWidth(30)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'http://img2.woyaogexing.com/2019/08/30/3c02345e50aa4fbbadce736ae72d9313!600x600.jpeg',
                fit: BoxFit.fill,
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setWidth(120),
              ),
            ),
          ),
          Text('当前绑定微信:xue-',style: TextStyle(fontSize: ScreenUtil().setSp(18))),
          SizedBox(height: ScreenUtil().setWidth(40)),
          SizedBox(
            width: ScreenUtil().setWidth(150),
            child: FlatButton(
              padding: EdgeInsets.all(10),
              onPressed: () => print('点击了重新绑定'),
              color: Theme.of(context).primaryColor,
              child: Text(
                '重新绑定',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(16)),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Expanded(
            child: Container(
              alignment:Alignment.bottomCenter,
              child: Text('*药匣子客服电话：4000-520-120',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)))
            )
          ),
          SizedBox(height: ScreenUtil().setWidth(20)),
        ],
      ),
    );
  }

}