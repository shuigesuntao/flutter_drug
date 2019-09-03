import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_config.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color(0xFFFAFAFA),
        title: Text('我的账户'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(RouteName.packetRule,arguments:'https://app.zgzydb.com/web/packetRule/index.html'),
                child: Center(
                  child: Text(
                    '提现规则',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                ),
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(ImageHelper.wrapAssets('bg_yue.png')))),
              child: Stack(
                children: <Widget>[
                  Text(
                    '账户余额',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: '￥',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                                text: '3.01',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white))
                          ]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Color(0xFFF8F8F8),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '0',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black))
                                ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '上月收入',
                            style: TextStyle(
                                color: Color(0xFF777777), fontSize: 12),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Container(
                      color: Color(0xFFD8D8D8),
                      width: 2,
                      height: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '0',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black))
                                ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '本月收入',
                            style: TextStyle(
                                color: Color(0xFF777777), fontSize: 12),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Container(
                      color: Color(0xFFD8D8D8),
                      width: 2,
                      height: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '0',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black))
                                ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '上月支出',
                            style: TextStyle(
                                color: Color(0xFF777777), fontSize: 12),
                          )
                        ],
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => print("点击了微信提现"),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      '微信提现',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => print("点击了查看账单"),
                    color: Colors.white,
                    child: Text(
                      '查看账单',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
