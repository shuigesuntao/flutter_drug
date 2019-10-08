import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/ui/widget/search_bar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:provider/provider.dart';

class PrescriptionPersonSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_,FriendModel model,__){
      return Scaffold(
        appBar: SearchBar(
          hintText: "请输入患者姓名或电话号码搜索",
          onPressed: (text) {
            model.filterData(text);
          },
          listener: (String text)=>{
            if (text.isEmpty){
              model.filterData(text)
            }
          },
        ),
        body: ListView.builder(
          itemCount: model.filterList.length,
          itemBuilder: (context, index) {
            return _buildPersonItem(model.filterList[index]);
          }));
    });
  }

  Widget _buildPersonItem(Friend friend){
    return Column(
      children: <Widget>[
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
