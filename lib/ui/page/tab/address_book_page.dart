import 'package:azlistview/azlistview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/view_model/firend_model.dart';

class AddressBookPage extends StatelessWidget {

  final int _suspensionHeight = 30;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FriendModel>(
      model: FriendModel(),
      onModelReady: (friendModel) => friendModel.initData(),
      builder: (context,friendModel,child){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('全部(${friendModel.friends?.length ?? 0})'),
                Image.asset(ImageHelper.wrapAssets('ic_arrow_drop_down.png'),
                  width: 15, height: 15)
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () => print('点击了搜索'),
                  child: Center(
                    child: Text(
                      '搜索',
                      style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ))
            ],
          ),
          body: AzListView(
            data: friendModel.friends,
            itemBuilder: (context, model) => _buildFriendItem(model),
            suspensionWidget: _buildSusWidget(friendModel.suspensionTag),
            isUseRealIndex: true,
            itemHeight: 60,
            suspensionHeight: _suspensionHeight,
            onSusTagChanged: (String tag) => friendModel.setSuspensionTag(tag),
          ),
        );
      },
    );
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
          fontSize: 14.0,
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
          offstage: friend.isShowSuspension != true,
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
                            child: Text('（${friend.name}）',style: TextStyle(color: Colors.grey)),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${_getGender(friend.gender)}${friend.age}岁 | 问诊${friend.askCount}次 | 购药${friend.buyDrugCount}次",
                        style: TextStyle(color: Colors.grey,fontSize: 13),
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
