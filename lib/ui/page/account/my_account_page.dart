import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              width: double.infinity,
              height: ScreenUtil().setWidth(150),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(ImageHelper.wrapAssets('bg_yue.png')))),
              child: Stack(
                children: <Widget>[
                  Text(
                    '账户余额（元）',
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(14)),
                  ),
                  Center(
                    child: Text(
                      '￥3.01',
                      style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12), color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '0',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14), color: Colors.black))
                              ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '上月收入',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Container(
                      color: Colors.grey[200],
                      width: 1,
                      height: ScreenUtil().setWidth(20),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12), color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '0',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14), color: Colors.black))
                              ]),
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(5),
                          ),
                          Text(
                            '本月收入',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Container(
                      color: Colors.grey[200],
                      width: 1,
                      height: ScreenUtil().setWidth(20),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12), color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '0',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14), color: Colors.black))
                              ]),
                          ),
                          SizedBox(
                            height: ScreenUtil().setWidth(5),
                          ),
                          Text(
                            '上月支出',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
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
                        height: ScreenUtil().setWidth(40),
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
                    SizedBox(height: ScreenUtil().setWidth(10)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.showAccount),
                      child: Container(
                        height: ScreenUtil().setWidth(40),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Theme.of(context).primaryColor, width: 1)
                        ),
                        child: Text(
                          '查看账单',
                          style: TextStyle(color:Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14)),
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
