import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '示例说明'),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text('头像示例', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Image.asset(ImageHelper.wrapAssets('txsl.png')),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('执业证书', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Image.asset(ImageHelper.wrapAssets('diyiye.png')),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Image.asset(ImageHelper.wrapAssets('dierye.png')),
            ),
            Text.rich(
              TextSpan(
                text: '*',
                style: TextStyle(color: Theme.of(context).primaryColor),
                children: [
                  TextSpan(
                    text: '上传资质信息仅用于认证，患者和第三方不可见',
                    style: TextStyle(color: Colors.grey)
                  )
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
