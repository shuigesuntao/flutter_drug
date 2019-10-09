import 'package:azlistview/azlistview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/ui/page/search/p_person_search_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:provider/provider.dart';

class PrescriptionOpenPage extends StatelessWidget {
  final int _suspensionHeight = 30;

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
                onTap: ()=> Navigator.of(context).pushNamed(RouteName.prescriptionPersonSearch),
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
                  itemBuilder: (context, model) =>
                    _buildFriendItem(model),
                  suspensionWidget:
                  _buildSusWidget(model.suspensionTag),
                  isUseRealIndex: true,
                  itemHeight: 60,
                  suspensionHeight: _suspensionHeight,
                  onSusTagChanged: (String tag) =>
                  model.suspensionTag = tag,
                );
              },)
            )
          ],
        ));
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildFriendItem(Friend friend) {
    String susTag = friend.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !friend.isShowSuspension,
          child: _buildSusWidget(susTag),
        ),
        Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: friend.headerUrl,
                    errorWidget: (context, url, error) => friend.gender == "女"
                        ? Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
                            width: 50, height: 50)
                        : Image.asset(ImageHelper.wrapAssets('gender_boy.png'),
                            width: 50, height: 50),
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            friend.displayName,
                            style: TextStyle(fontSize: 16),
                          ),
                          Offstage(
                            offstage:
                                friend.name == null || friend.name.isEmpty,
                            child: Text('（${friend.name}）',
                                style: TextStyle(color: Colors.grey)),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${_getGender(friend.gender)}${friend.age}岁 | 问诊${friend.askCount}次 | 购药${friend.buyDrugCount}次",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      )
                    ],
                  ),
                ))
              ],
            )),
        Divider(height: 1)
      ],
    );
  }

  _getGender(String gender) {
    String genderStr = "";
    if (gender != null && gender.isNotEmpty) {
      genderStr = "$gender | ";
    }
    return genderStr;
  }
}
