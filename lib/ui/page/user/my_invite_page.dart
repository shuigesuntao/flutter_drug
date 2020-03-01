

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/my_invite.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/my_invite_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyInvitePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '全部邀请'),
      body: ProviderWidget<MyInviteModel>(
        model: MyInviteModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return Center(child: CircularProgressIndicator());
          } else if (model.isError) {
            return ViewStateWidget(onPressed: model.initData);
          }
          return SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child:model.isEmpty ? ViewStateEmptyWidget() : ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                return _buildMyInviteItem(model.list[index]);
              }
            )
          );
        },
      )
    );
  }


  Widget _buildMyInviteItem(MyInvite user){
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:user.imageUrl,
            errorWidget: (context, url, error) => user.gender == "女"
              ? Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
              width: ScreenUtil().setWidth(42), height: ScreenUtil().setWidth(42))
              : Image.asset(ImageHelper.wrapAssets('gender_boy.png'),
              width: ScreenUtil().setWidth(42), height: ScreenUtil().setWidth(42)),
            fit: BoxFit.fill,
            width: ScreenUtil().setWidth(42),
            height: ScreenUtil().setWidth(42),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(user.name,style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(15))),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Image.asset(ImageHelper.wrapAssets(user.type == 0?'icon_yh.png':user.auth == 0?'icon_ys_wrz.png':'icon_ys_yrz.png'),width: ScreenUtil().setWidth(28),height: ScreenUtil().setWidth(14),)
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(3)),
                Text('${user.gender} | ${user.phone}',style: TextStyle(color: Colors.grey,fontSize:  ScreenUtil().setSp(13))),
                SizedBox(height: ScreenUtil().setWidth(3)),
                Text('邀请加入时间：${user.time}',style: TextStyle(color: Colors.grey,fontSize:  ScreenUtil().setSp(13)))
              ],
            )
          )
        ],
      ),
    );
  }
}