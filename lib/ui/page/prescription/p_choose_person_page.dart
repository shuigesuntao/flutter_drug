import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:provider/provider.dart';

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
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,5,15,5),
                        child: Image.asset(ImageHelper.wrapAssets('edit_search.png'),width: 18,height: 18),
                      ),
                      Text('请输入姓名或手机号查找患者',style: TextStyle(color: Colors.grey,fontSize: 16),)
                    ],
                  )
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10,20,10,10),
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.fromLTRB(15,20,15,20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('phone_kf.png'),
                          width: 45, height: 45),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('手机号开方', style: TextStyle(fontSize: 18)),
                            Text('填写患者手机号',style: TextStyle(color: Colors.grey[800]))
                          ],
                        )
                      ],
                    ),
                  )),
                  SizedBox(width: 10),
                  Expanded(child:Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.fromLTRB(15,20,15,20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('wx_kf.png'),
                          width: 45, height: 45),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('微信开方', style: TextStyle(fontSize: 18)),
                            Text('发送到患者微信',style: TextStyle(color: Colors.grey[800]))
                          ],
                        )
                      ],
                    ),
                  )),
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
