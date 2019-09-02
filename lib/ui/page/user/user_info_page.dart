import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/me_header.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF33D0C8),
        elevation: 0,
        title: Text(
          '我的名片',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  '分享',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ))
        ],
      ),
      body: Column(
        children: <Widget>[
          UserInfoHeader(
            headerBg: 'bg_mingpian.png',
            imageUrl:
            'http://img2.woyaogexing.com/2019/08/30/3c02345e50aa4fbbadce736ae72d9313!600x600.jpeg',
            name: '许洪亮',
            type: '内科',
            job: '职业医师',
            hasRightIcon: false,
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3ECD0),
                    borderRadius: BorderRadius.circular(5)),
                  child: Text('公告：找'),
                ),
                Text(
                  '擅长领域',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Color(0xFFF8F8F8),
                  child: Text(
                    '内科',
                  ),
                ),
                Text(
                  '个人简介',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(10),
                  color: Color(0xFFF8F8F8),
                  child: Text(
                    '我是职业中医师，您有什么日常身体疾病需要帮助，可以给我图文留言或者电话咨询',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,40),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => print("点击了编辑"),
                    color: Theme
                      .of(context)
                      .primaryColor,
                    child: Text(
                      '编辑',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              )
            )
          )
        ],
      ),
    );
  }
}
