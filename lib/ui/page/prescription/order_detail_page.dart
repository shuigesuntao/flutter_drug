import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailPage extends StatelessWidget {
  final int count;

  final String time = '2019-10-09 20:38:42';

  OrderDetailPage({this.count = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, '处方详情', actionText: '复制处方',
            onActionPress: () {
          Navigator.of(context)
              .pushNamed(RouteName.openPrescription, arguments: null);
        }),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Offstage(
                  offstage: count != 0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Divider(height: 0.5, color: Colors.grey[400]),
                        SizedBox(height: ScreenUtil().setWidth(15)),
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          Image.asset(ImageHelper.wrapAssets('icon_cfsc.png'),
                              width: ScreenUtil().setWidth(16), height: ScreenUtil().setWidth(16)),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Text('处方已生成',style: TextStyle(fontSize: ScreenUtil().setSp(15)))
                        ]),
                        SizedBox(height: ScreenUtil().setWidth(15)),
                        Text('患者绑定【药匣子在线】微信公众号可以直接购买',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                        SizedBox(height: ScreenUtil().setWidth(10)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
                            child: Image.asset(
                                ImageHelper.wrapAssets('xuxian.png'))),
                        SizedBox(height: ScreenUtil().setWidth(5)),
                        Text('您也可以用以下方式帮助患者支付', style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                        SizedBox(height: ScreenUtil().setWidth(20)),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Image.asset(
                                    ImageHelper.wrapAssets('icon_zhifu02.png'),
                                    width: ScreenUtil().setWidth(40),
                                    height: ScreenUtil().setWidth(40)),
                                SizedBox(height: ScreenUtil().setWidth(10)),
                                Text('分享患者付款', style: TextStyle(fontSize: ScreenUtil().setSp(13)))
                              ],
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return GenderChooseDialog();
                                    });
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                      ImageHelper.wrapAssets(
                                          'icon_zhifu01.png'),
                                      width: ScreenUtil().setWidth(40),
                                      height: ScreenUtil().setWidth(40)),
                                  SizedBox(height: ScreenUtil().setWidth(10)),
                                  Text('患者扫码支付', style: TextStyle(fontSize: ScreenUtil().setSp(13)))
                                ],
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                                  onTap: ()=>Navigator.of(context).pushNamed(RouteName.confirmOrder),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                      ImageHelper.wrapAssets(
                                          'icon_zhifu03.png'),
                                      width: ScreenUtil().setWidth(40),
                                      height: ScreenUtil().setWidth(40)),
                                  SizedBox(height: ScreenUtil().setWidth(10)),
                                  Text('医师代患者付', style: TextStyle(fontSize: ScreenUtil().setSp(13)))
                                ],
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(20))
                      ],
                    ),
                  ),
                ),
                Offstage(
                  offstage: count == 0,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(6, 1, 6, 1),
                            decoration: BoxDecoration(
                                color: Color(0xffe56068),
                                borderRadius: BorderRadius.circular(3)),
                            child: Text('第$count次',
                                style: TextStyle(
                                    color: Colors.white, fontSize: ScreenUtil().setSp(12))),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text('$time 开方', style: TextStyle(fontSize: ScreenUtil().setSp(15)))
                        ],
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(15)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                              ImageHelper.wrapAssets('icon_zhenduan.png'),
                              width: ScreenUtil().setWidth(15),
                              height: ScreenUtil().setWidth(15)),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text(
                            '诊断',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(15)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【手机】 13426288108',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【患者】 余英 女 22岁',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【病症】 风燥伤肺症',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【辩证】 舌干咳嗽',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(15)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                              ImageHelper.wrapAssets('icon_kaifang.png'),
                              width: ScreenUtil().setWidth(15),
                              height: ScreenUtil().setWidth(15)),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text(
                            '开方',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(10)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                          child: Text('药匣子优选-汤剂(代煎)',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Divider(height: 0.5, color: Colors.grey[300]),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                          child: Text('R:',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(22), fontWeight: FontWeight.w500))),
                      Stack(
                        children: <Widget>[
                          Image.asset(ImageHelper.wrapAssets('kuang_left.png'),
                              width: ScreenUtil().setWidth(12), height: ScreenUtil().setWidth(12)),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                            color: Color(0x26eedd8f),
                            child: Wrap(
                              spacing: 20,
                              children: _buildDrugWidgets(),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Image.asset(
                                ImageHelper.wrapAssets('kuang_right.png'),
                                width: ScreenUtil().setWidth(12),
                                height: ScreenUtil().setWidth(12)),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                        child: Divider(height: 0.5, color: Colors.grey[400]),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '共',
                              style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),
                              children: <TextSpan>[
                            TextSpan(
                                text: ' 7 ',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14))),
                            TextSpan(
                              text: '剂，每剂',
                              style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),
                            ),
                            TextSpan(
                              text: ' 2 ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14)),
                            ),
                            TextSpan(
                              text: '袋，每袋',
                              style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),
                            ),
                            TextSpan(
                              text: ' 200 ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14)),
                            ),
                            TextSpan(
                              text: 'ml',
                              style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),
                            ),
                          ])),
                      SizedBox(height: 10),
                      Text('【煎药方式】 代煎',style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(15)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                              ImageHelper.wrapAssets('icon_yizhu_small.png'),
                              width: ScreenUtil().setWidth(15),
                              height: ScreenUtil().setWidth(15)),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text(
                            '医嘱',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(15)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【用药方法】 内服',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【用药医嘱】 辛辣',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('【补充医嘱】 勿捂，及时添减衣服',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                        child: Divider(height: 0.5, color: Colors.grey[400]),
                      ),
                      Text('【患者是否可见处方】 可见',style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(15)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(ImageHelper.wrapAssets('icon_huajia.png'),
                              width: ScreenUtil().setWidth(15), height: ScreenUtil().setWidth(15)),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text(
                            '划价',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(15)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text('药费',style: TextStyle(fontSize: ScreenUtil().setSp(14))), Text('￥275.19',style: TextStyle(fontSize: ScreenUtil().setSp(14)))],
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text('诊费',style: TextStyle(fontSize: ScreenUtil().setSp(14))), Text('￥0.00',style: TextStyle(fontSize: ScreenUtil().setSp(14)))],
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('单次处方服务费',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                                  Text(
                                    '（附加到药费展示）',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: ScreenUtil().setSp(12)),
                                  )
                                ],
                              ),
                              Text('￥0.00',style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('处方加工费',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                              Text('￥0.00',style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                        child: Divider(height: 0.5, color: Colors.grey[400]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('处方合计',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(15))),
                          Text('￥275.19',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(15)))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('处方编号：20191009203842214066289RP',
                              style: TextStyle(fontSize: ScreenUtil().setSp(12)))),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                          child: Text('创建时间：$time',
                              style: TextStyle(fontSize: ScreenUtil().setSp(12)))),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
              ],
            ),
            bottom: true,
          ),
        ));
  }

  /// 药品列表
  List<Widget> _buildDrugWidgets() {
    return [
      Drug('枳实', 30),
      Drug('白术', 30),
      Drug('桑叶', 28),
      Drug('桑叶', 28),
      Drug('桑叶', 28),
      Drug('桑叶', 28),
      Drug('桑叶', 28),
      Drug('桑叶', 28),
      Drug('炒苦杏仁', 59),
      Drug('菊花', 30)
    ]
        .map((drug) => Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            child: Text(
              '${drug.name} ${drug.count} ${drug.unit}',style: TextStyle(fontSize: ScreenUtil().setSp(14)),
            )))
        .toList();
  }
}

class GenderChooseDialog extends Dialog {
  GenderChooseDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30),ScreenUtil().setWidth(15),ScreenUtil().setWidth(30),ScreenUtil().setWidth(15)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
                child: Column(children: <Widget>[
                  Text('处方已划价',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      color: Theme.of(context).primaryColor)),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  Divider(height: 0.5, color: Colors.grey[400]),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  Text('请患者微信扫码购药', style: TextStyle(fontSize: ScreenUtil().setSp(18))),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  QrImage(
                    data: 'asdawdasdawdeawdawdawd',
                    version: QrVersions.auto,
                    size: ScreenUtil().setWidth(170),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  Divider(height: 0.5, color: Colors.grey[400]),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('支付操作步骤：',style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                      Text('1、填写收货人地址；2、完成付款。',style: TextStyle(fontSize: ScreenUtil().setSp(12)))
                    ],
                  )
                ])
              ),
              Positioned(
                right: ScreenUtil().setWidth(55),
                top: ScreenUtil().setWidth(50),
                child: GestureDetector(
                  onTap: ()=> Navigator.maybePop(context),
                  child: Image.asset(ImageHelper.wrapAssets('icon_shanchu_gray.png'),width: ScreenUtil().setWidth(12),height: ScreenUtil().setWidth(12)),
                )
              )
            ],
          )
        ]
      )
    );
  }

}
