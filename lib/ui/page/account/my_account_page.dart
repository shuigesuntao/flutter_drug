import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.buildCommonAppBar(context, '我的账户',
          actionText: '提现规则',
          onActionPress: () => Navigator.of(context).pushNamed(
              RouteName.cashRule,
              arguments: 'https://app.zgzydb.com/web/packetRule/index.html')),
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
                    padding: EdgeInsets.all(12),
                    onPressed: () => Navigator.of(context).pushNamed(RouteName.weChatCash),
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
                    onPressed: () => Navigator.of(context).pushNamed(RouteName.showAccount),
                    color: Colors.white,
                    child: Text(
                      '查看账单',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
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
