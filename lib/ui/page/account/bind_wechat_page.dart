import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class BindWeChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '绑定微信',actionText: '解绑',onActionPress: (){
        print('点击了解绑');
      }),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'http://img2.woyaogexing.com/2019/08/30/3c02345e50aa4fbbadce736ae72d9313!600x600.jpeg',
                fit: BoxFit.fill,
                width: 120,
                height: 120,
              ),
            ),
          ),
          Text('当前绑定微信:xue-',style: TextStyle(fontSize: 18)),
          SizedBox(height: 40),
          SizedBox(
            width: 150,
            child: FlatButton(
              padding: EdgeInsets.all(10),
              onPressed: () => print('点击了重新绑定'),
              color: Theme.of(context).primaryColor,
              child: Text(
                '重新绑定',
                style: TextStyle(color: Colors.white,fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Expanded(
            child: SafeArea(
              bottom: true,
              child: Container(
                alignment:Alignment.bottomCenter,
                child: Text('*药匣子客服电话：4000-520-120',style: TextStyle(color: Colors.grey))
              )
            )
          )
        ],
      ),
    );
  }

}