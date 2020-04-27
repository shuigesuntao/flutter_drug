import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteDoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.buildCommonAppBar(context, '推荐有奖'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(ImageHelper.wrapAssets('big_img.png'),
                    fit: BoxFit.fill),
                Positioned(
                    top: ScreenUtil().setWidth(5),
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        _goToWebPage(
                          context,
                          '规则',
                          'http://wx.zgzydb.com/web4/doctorSide/#/inviteRule',
                          false);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(10),
                          ScreenUtil().setWidth(3),
                          ScreenUtil().setWidth(15),
                          ScreenUtil().setWidth(3)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                        child: Text('规则',
                          style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                      ),
                    )
                )
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(30),
                          bottom: ScreenUtil().setWidth(15)),
                      child: Text('参与步骤',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.bold))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(ImageHelper.wrapAssets('yqthimg.png'),
                          width: ScreenUtil().setWidth(80),
                          height: ScreenUtil().setWidth(80)),
                      Image.asset(ImageHelper.wrapAssets('right_jt.png'),
                          width: ScreenUtil().setWidth(14),
                          height: ScreenUtil().setWidth(9)),
                      Image.asset(ImageHelper.wrapAssets('jsyqimg.png'),
                          width: ScreenUtil().setWidth(80),
                          height: ScreenUtil().setWidth(80)),
                      Image.asset(ImageHelper.wrapAssets('right_jt.png'),
                          width: ScreenUtil().setWidth(14),
                          height: ScreenUtil().setWidth(9)),
                      Image.asset(ImageHelper.wrapAssets('jldzimg.png'),
                          width: ScreenUtil().setWidth(80),
                          height: ScreenUtil().setWidth(80)),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(30),
                          bottom: ScreenUtil().setWidth(15)),
                      child: Text('立即邀请',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.bold))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(ImageHelper.wrapAssets('wxyq.png'),
                          width: ScreenUtil().setWidth(172),
                          height: ScreenUtil().setWidth(60)),
                      Image.asset(ImageHelper.wrapAssets('pyqyq.png'),
                          width: ScreenUtil().setWidth(172),
                          height: ScreenUtil().setWidth(60)),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(40),
                          bottom: ScreenUtil().setWidth(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('奖励进度',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: <Widget>[
                              Text('明细 ',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.bold)),
                              Image.asset(
                                  ImageHelper.wrapAssets(
                                      'youjiantou_new2x.png'),
                                  width: 12,
                                  height: 12)
                            ],
                          )
                        ],
                      )),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageHelper.wrapAssets('yyjx.png')),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all( ScreenUtil().setWidth(10)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Text('0',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(16),
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    Text(' 元',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(10)))
                                  ]),
                              SizedBox(height: ScreenUtil().setWidth(5)),
                              Text('已注册',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12)))
                            ],
                          ),
                        ),
                        Container(width: 1,height: ScreenUtil().setWidth(35),color: Colors.grey[300]),
                        Padding(
                          padding: EdgeInsets.all( ScreenUtil().setWidth(10)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text('0',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: Theme.of(context)
                                        .primaryColor)),
                                  Text(' 元',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10)))
                                ]),
                              SizedBox(height: ScreenUtil().setWidth(5)),
                              Text('已认证',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12)))
                            ],
                          ),
                        ),
                        Container(width: 1,height: ScreenUtil().setWidth(35),color: Colors.grey[300]),
                        Padding(
                          padding: EdgeInsets.all( ScreenUtil().setWidth(10)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text('0',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: Theme.of(context)
                                        .primaryColor)),
                                  Text(' 元',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10)))
                                ]),
                              SizedBox(height: ScreenUtil().setWidth(5)),
                              Text('累计药费奖励',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12)))
                            ],
                          ),
                        ),
                        Container(width: 1,height: ScreenUtil().setWidth(35),color: Colors.grey[300]),
                        Padding(
                          padding: EdgeInsets.all( ScreenUtil().setWidth(10)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text('0',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: Theme.of(context)
                                        .primaryColor)),
                                  Text(' 元',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10)))
                                ]),
                              SizedBox(height: ScreenUtil().setWidth(5)),
                              Text('共获得',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12)))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _goToWebPage(BuildContext context, String title, String url, bool isShare) {
    Map map = Map();
    map['title'] = title;
    map['url'] = url;
    map['share'] = isShare;
    Navigator.of(context).pushNamed(RouteName.webView, arguments: map);
  }
}
