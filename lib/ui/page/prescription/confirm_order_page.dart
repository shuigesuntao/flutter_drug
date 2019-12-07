

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/address.dart';
import 'package:flutter_drug/ui/page/user/address_manager_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmOrderPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_ConfirmOrderPageState();

}

class _ConfirmOrderPageState extends State<ConfirmOrderPage>{
  Address address = Address('诸葛亮', '18686868686', 1, '北京市朝阳区', '八里庄住邦2000商务中心2号');

  double balance = 5.01;
  bool isBalance = false;
  double totalPrice = 275.19;
  int _payWay = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '确认订单'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(height: 0.5,color: Colors.grey[400]),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddressManagePage(isSelect: true))).then((address) {
                          if(address != null){
                            setState(() {
                              this.address = address;
                            });
                          }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('收货人：${address.name}  ${address.phone}',style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('收货地址：',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                Expanded(child: Text('${address.area}--${address.address}',style: TextStyle(fontSize: ScreenUtil().setSp(12))),)
                              ],
                            )
                          ],
                        )),
                        SizedBox(width: ScreenUtil().setWidth(50)),
                        Row(
                          children: <Widget>[
                            Text('编辑',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor)),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: ScreenUtil().setWidth(20),
                              color: Colors.grey[600],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Image.asset(ImageHelper.wrapAssets('honglt.png')),
                Container(
                  margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),child: Row(
                        children: <Widget>[
                          Container(
                            width: 4,
                            height: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text('物流配送',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey[800]))
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(10),ScreenUtil().setWidth(15),ScreenUtil().setWidth(10)),
                        child: Text('顺丰速运（90%地区次日达，满100包邮）',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),child: Row(
                        children: <Widget>[
                          Container(
                            width: 4,
                            height: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text('处方详情',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey[800]))
                        ],
                      )),
                      Container(
                        color: Color(0xfffdfaee),
                        padding: EdgeInsets.fromLTRB(15,5,15,5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text('姓名',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                  SizedBox(height: 5),
                                  Text('david',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                ],
                              )
                            ),
                            Container(width: 1,height: 10,color: Colors.grey[300]),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text('性别',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                  SizedBox(height: 5),
                                  Text('男',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                ],
                              )
                            ),
                            Container(width: 1,height: 10,color: Colors.grey[300]),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text('年龄',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                  SizedBox(height: 5),
                                  Text('10',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25),ScreenUtil().setWidth(15),ScreenUtil().setWidth(25),ScreenUtil().setWidth(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('诊断：上火',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            RichText(text: TextSpan(
                              text: '处方剂型：药匣子优选-饮片(不加工)',
                              style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(13)),
                              children: [
                                TextSpan(
                                  text: 'X7',
                                  style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(13))
                                ),
                                TextSpan(
                                  text: '剂',
                                  style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(13))
                                ),
                              ]
                            )),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Text('处方医生：许洪亮',style: TextStyle(fontSize: ScreenUtil().setSp(13)))
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),child: Divider(height: 0.5,color: Colors.grey[300])),
                      Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(10)),child: Row(
                        children: <Widget>[
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(RouteName.orderDetail, arguments: 2),
                            child: Row(
                              children: <Widget>[
                                Text('查看更多详情',style: TextStyle(color: Colors.grey[600],fontSize: ScreenUtil().setSp(13))),
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 20,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),child: Row(
                        children: <Widget>[
                          Container(
                            width: 4,
                            height: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 10),
                          Text('支付方式',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey[800]))
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),2,ScreenUtil().setWidth(15),2),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('使用账户余额',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                            ),
                            Text('余额5.01元', style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(13))),
                            SizedBox(width: ScreenUtil().setWidth(5)),
                            GestureDetector(
                              onTap: ()=>  setState(() {
                                isBalance = !isBalance;
                              }),
                              child: CupertinoSwitch(
                                activeColor: Theme.of(context).primaryColor,
                                value: isBalance,
                                onChanged: (value) {
                                  setState(() {
                                    isBalance = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),child: Divider(height: 0.5,color: Colors.grey[300])),
                      GestureDetector(
                        onTap: ()=> showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            message: Text('请选择支付方式'),
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('取消')),
                            actions: _buildPayWayActions(),
                          )),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(10),ScreenUtil().setWidth(15),ScreenUtil().setWidth(10)),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text('选择方式',style: TextStyle(fontSize: ScreenUtil().setSp(13)))),
                              Row(
                                children: <Widget>[
                                  Image.asset(ImageHelper.wrapAssets(_payWay == 1?'icon_wx.png':'icon_zfb.png'),width: ScreenUtil().setWidth(20),height: ScreenUtil().setWidth(20)),
                                  SizedBox(width: ScreenUtil().setWidth(10)),
                                  Text(_payWay == 1?'微信支付':'支付宝支付',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                  Icon(
                                    CupertinoIcons.right_chevron,
                                    size: ScreenUtil().setWidth(20),
                                    color: Colors.grey[600],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),child: Row(
                        children: <Widget>[
                          Container(
                            width: 4,
                            height: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text('订单金额',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey[800]))
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(10),ScreenUtil().setWidth(15),ScreenUtil().setWidth(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('药费',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                Text('￥$totalPrice',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600)),
                              ],
                            ),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('诊费',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                Text('￥0.00',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                              ],
                            ),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('加工费',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                Text('￥0.00',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                              ],
                            ),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('运费',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                                Text('￥0.00',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('*平台全面启动电子普通发票，请联系客服进行开具；',style: TextStyle(fontSize:ScreenUtil().setSp(12),color: Colors.grey)),
                    SizedBox(height: 3),
                    Text('*药品除质量原因外，一经售出，不予退回；',style: TextStyle(fontSize:ScreenUtil().setSp(12),color: Colors.grey)),
                    SizedBox(height: 3),
                    Text('*发票问题及药品质量投诉电话:400-0520-120',style: TextStyle(fontSize:ScreenUtil().setSp(12),color: Colors.grey)),
                  ],
                )),
                SizedBox(height: 15),
              ],
            )
          )
          ),
          SafeArea(
            bottom: true,
            child: Container(
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(
                    height: ScreenUtil().setWidth(50),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '应付款：',
                            style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(15)),
                            children: [
                              TextSpan(
                                text: '￥${isBalance ? totalPrice-balance : totalPrice}',
                                style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(15),fontWeight: FontWeight.w600)
                              )
                            ]
                          ),
                        ),
                        Offstage(
                          offstage: !isBalance,
                          child: Text('余额抵扣:￥$balance',style: TextStyle(color: Colors.grey[600],fontSize: ScreenUtil().setSp(12))),
                        )
                      ],
                    )
                  )),
                  GestureDetector(
                    onTap: (){},
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(35)),
                      height: ScreenUtil().setWidth(50),
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text('去付款',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );

  }


  /// 选择性别
  List<Widget> _buildPayWayActions() {
    final List<String> payWays = [
      '微信支付',
      '支付宝支付',
    ];
    return payWays
      .map((way) => CupertinoActionSheetAction(
      onPressed: () {
        setState(() {
          _payWay = way == '微信支付' ? 1 : 2;
        });
        Navigator.maybePop(context);
      },
      child: Text(way))).toList();
  }
}