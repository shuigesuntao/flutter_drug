

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class FinishOrderDetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '订单详情',actionText: '复制处方',onActionPress: (){
        Navigator.of(context).pushNamed(
          RouteName.openPrescription,
          arguments: null
        );
      }),
      body: SingleChildScrollView(
        child: SafeArea(child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              color: Color(0xffe56068),
              child: Text('订单已完成',style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('收货人：诸葛亮 18686868686',style: TextStyle(color: Colors.black)),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('收货地址：',style: TextStyle(fontSize: 13)),
                      Expanded(child: Text('北京朝阳区--高碑店xxx小区xx楼xxx号',style: TextStyle(fontSize: 12)),)
                    ],
                  )
                ],
              ),
            ),
            Image.asset(ImageHelper.wrapAssets('honglt.png')),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      Text('物流配送',style: TextStyle(fontSize: 12,color: Colors.grey[800]))
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15,10,15,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('配送进度'),
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            children: <Widget>[
                              Text('查看物流',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 13)),
                              Icon(
                                CupertinoIcons.right_chevron,
                                size: 20,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Divider(height: 0.5,color: Colors.grey[300])),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15,10,15,10),
                    child: Text('顺丰速运（90%地区次日达，满100包邮）'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      Text('处方详情',style: TextStyle(fontSize: 12,color: Colors.grey[800]))
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
                              Text('姓名',style: TextStyle(fontSize: 12)),
                              SizedBox(height: 5),
                              Text('david',style: TextStyle(fontSize: 12)),
                            ],
                          )
                        ),
                        Container(width: 1,height: 10,color: Colors.grey[300]),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('性别',style: TextStyle(fontSize: 12)),
                              SizedBox(height: 5),
                              Text('男',style: TextStyle(fontSize: 12)),
                            ],
                          )
                        ),
                        Container(width: 1,height: 10,color: Colors.grey[300]),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('年龄',style: TextStyle(fontSize: 12)),
                              SizedBox(height: 5),
                              Text('0',style: TextStyle(fontSize: 12)),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('诊断：上火',style: TextStyle(fontSize: 13)),
                        SizedBox(height: 10),
                        RichText(text: TextSpan(
                          text: '处方剂型：药匣子优选-饮片(不加工)',
                          style: TextStyle(color: Colors.black87,fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'X7',
                              style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 13)
                            ),
                            TextSpan(
                              text: '剂',
                              style: TextStyle(color: Colors.black87,fontSize: 13)
                            ),
                          ]
                        )),
                        SizedBox(height: 10),
                        Text('处方医生：许洪亮',style: TextStyle(fontSize: 13))
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Divider(height: 0.5,color: Colors.grey[300])),
                  Padding(padding: EdgeInsets.fromLTRB(0,10,10,10),child: Row(
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: ()=> Navigator.of(context).pushNamed(RouteName.orderDetail, arguments: 2),
                        child: Row(
                          children: <Widget>[
                            Text('查看更多详情',style: TextStyle(color: Colors.grey[600],fontSize: 13)),
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
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      Text('订单金额',style: TextStyle(fontSize: 12,color: Colors.grey[800]))
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15,10,15,10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('药费',style: TextStyle(fontSize: 13)),
                            Text('￥8.61',style: TextStyle(fontSize: 13,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('诊费',style: TextStyle(fontSize: 13)),
                            Text('￥0.00',style: TextStyle(fontSize: 13)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('加工费',style: TextStyle(fontSize: 13)),
                            Text('￥0.00',style: TextStyle(fontSize: 13)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('运费',style: TextStyle(fontSize: 13)),
                            Text('￥15.00',style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Divider(height: 0.5,color: Colors.grey[300])),
                  Padding(padding: EdgeInsets.fromLTRB(0,10,15,10),child: Row(
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      Text('实付款：￥23.61',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 15)),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('订单编号：20180710183605415066902B',style: TextStyle(fontSize: 12)),
                  SizedBox(height: 10),
                  Text('支付方式：微信支付',style: TextStyle(fontSize: 12)),
                  SizedBox(height: 10),
                  Text('交易时间：2018-07-10 18:36:24',style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),bottom: true),
      ),
    );
  }

}