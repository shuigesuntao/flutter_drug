
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class FollowUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '随访说明'),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Color(0xffe56068),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('1、平台将依据您设置的随访时间,自动给予患者发送用药随访订单;',style: TextStyle(fontSize: 12,color: Colors.white)),
                SizedBox(height: 5),
                Text('1、随访将有助于您了解患者服药疗效,便于您的下次诊疗调方。',style: TextStyle(fontSize: 12,color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Text('示例随访单',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                  SizedBox(height: 5),
                  Text('共3题',style: TextStyle(fontSize: 12,color: Colors.grey)),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('1、服药后病情是否有所改善？'),
                      SizedBox(height: 15),
                      Text('医生您好，服药过后疼痛减轻了。',style: TextStyle(fontSize: 12,color: Colors.grey)),
                      SizedBox(height: 10),
                      Divider(height: 1,color: Colors.grey[400]),
                      SizedBox(height: 20),
                      Text('2、服药后是否出现新的症状？'),
                      SizedBox(height: 15),
                      Text('我吃药3天后轻微腹泻，请问是否正常？',style: TextStyle(fontSize: 12,color: Colors.grey)),
                      SizedBox(height: 10),
                      Divider(height: 1,color: Colors.grey[400]),
                      SizedBox(height: 20),
                      Text('3、请上传舌苔照片'),
                      SizedBox(height: 15),
                      Image.asset(ImageHelper.wrapAssets('shilie.png'),width: 70,height: 70)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}