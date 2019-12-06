import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'p_open_page.dart';

class PrescriptionChoosePersonPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar.buildCommonAppBar(
          context,
          '选择开方患者',
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15,10,15,10),
              color: Colors.white,
              child: GestureDetector(
                onTap: ()=> Navigator.of(context).pushNamed(RouteName.prescriptionPersonSearch,arguments: 2),
                child: Container(
                  height: ScreenUtil().setWidth(30),
                  decoration: BoxDecoration(
                    color: Color(0xffeeeeed),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12,5,10,5),
                        child: Image.asset(ImageHelper.wrapAssets('icon_sousuo.png'),width: 14,height: 14),
                      ),
                      Text('请输入姓名或手机号查找患者',style: TextStyle(color: Colors.grey[400],fontSize: ScreenUtil().setSp(14)))
                    ],
                  )
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10,15,10,0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: ()=> Navigator.push(context,CupertinoPageRoute(builder: (context)=>PrescriptionOpenPage(friend:null,isWeChat:false))),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets('icon_shouji.png'),
                              width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('手机号开方', style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                                SizedBox(height: 3),
                                Text('填写患者手机号',style: TextStyle(fontSize:ScreenUtil().setSp(12),color: Colors.grey[700]))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                  SizedBox(width: ScreenUtil().setWidth(8)),
                  Expanded(
                    child:GestureDetector(
                      onTap: ()=> Navigator.push(context,CupertinoPageRoute(builder: (context)=>PrescriptionOpenPage(friend:null,isWeChat:true))),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets('wx_kf.png'),
                              width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('微信开方', style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                                SizedBox(height: 3),
                                Text('发送到患者微信',style: TextStyle(fontSize:ScreenUtil().setSp(12),color: Colors.grey[700]))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer(builder: (context, FriendModel model, child) {
                return  AzListView(
                  data: model.list,
                  itemBuilder: (context, model) => FriendItemWidget(
                    friend:model,
                    onItemClick:(model)=> Navigator.of(context).pushNamed(
                      RouteName.openPrescription,
                      arguments: model
                    ),
                    isShowIndex:model.isShowSuspension
                  ),
                  indexBarBuilder:(BuildContext context, List<String> tags, IndexBarTouchCallback onTouch){
                    return IndexBar(
                      textStyle:TextStyle(fontSize: ScreenUtil().setSp(12)),
                      touchDownTextStyle:TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey),
                      touchDownColor: Colors.transparent,
                      data: tags,
                      onTouch: onTouch,
                    );
                  },
                  suspensionWidget: SusWidget(tag:model.suspensionTag),
                  isUseRealIndex: true,
                  itemHeight: 60,
                  suspensionHeight: 30,
                  onSusTagChanged: (String tag) =>
                  model.suspensionTag = tag,
                );
              },)
            )
          ],
        ));
  }
}
