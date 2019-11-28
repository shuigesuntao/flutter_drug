import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '我的账户', actionText: '提现规则',
        onActionPress: () {
          Map map = Map();
          map['title'] = '提现规则';
          map['url'] = 'https://app.zgzydb.com/web/packetRule/index.html';
          map['share'] = false;
          Navigator.of(context).pushNamed(RouteName.webView, arguments: map);
        }),
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
                    '账户余额（元）',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Center(
                    child: Text(
                      '￥3.01',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
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
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Container(
                      color: Colors.grey[200],
                      width: 1,
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
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Container(
                      color: Colors.grey[200],
                      width: 1,
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
                            style: TextStyle(fontSize: 12),
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
              child: SafeArea(
                bottom: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () =>
                        Navigator.of(context).pushNamed(RouteName.weChatCash),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme
                            .of(context)
                            .primaryColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          '微信提现',
                          style: TextStyle(color: Colors.white),
                        )
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.showAccount),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Theme.of(context).primaryColor, width: 1)
                        ),
                        child: Text(
                          '查看账单',
                          style: TextStyle(color:Theme.of(context).primaryColor),
                        )
                      ),
                    )
                  ],
                )))
          ],
        ),
      ),
    );
  }
}
