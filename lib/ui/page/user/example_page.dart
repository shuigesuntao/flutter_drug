import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '示例说明'),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('头像示例', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.symmetric(vertical: 15),
            child: Image.asset(ImageHelper.wrapAssets('txsl.png'),width: 220,height: 72,fit: BoxFit.fill)),
            Text('执业证书', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Image.asset(ImageHelper.wrapAssets('diyiye.png'),width: 272,height: 172,fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Image.asset(ImageHelper.wrapAssets('dierye.png'),width: 272,height: 172,fit: BoxFit.fill),
            ),
            Text.rich(
              TextSpan(
                text: '*',
                style: TextStyle(color: Theme.of(context).primaryColor),
                children: [
                  TextSpan(
                    text: '上传资质信息仅用于认证，患者和第三方不可见',
                    style: TextStyle(color: Colors.grey,fontSize: 12)
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
