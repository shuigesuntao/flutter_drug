import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/check_message_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'p_open_page.dart';

class CheckMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, '审方消息'),
        body: ProviderWidget<CheckMessageModel>(
            model: CheckMessageModel(),
            onModelReady: (model) {
              model.initData();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return Center(child: CircularProgressIndicator());
              } else if (model.error) {
                return ViewStateWidget(onPressed: model.initData);
              }
              return SmartRefresher(
                controller: model.refreshController,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                enablePullUp: !model.empty,
                child: model.empty
                    ? ViewStateEmptyWidget()
                    : ListView.builder(
                        itemCount: model.list?.length ?? 0,
                        itemBuilder: (context, index) {
                          return _buildMessageItem(context, index, model);
                        },
                      ),
              );
            }));
  }

  Widget _buildMessageItem(
      BuildContext context, int index, CheckMessageModel model) {
    return GestureDetector(
      onTap: (){
        if(model.list[index].status == 1){
          Navigator.push(context,CupertinoPageRoute(builder: (context)=>PrescriptionOpenPage(friend:null,isImage:true)));
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff9f9f9),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5))
              ),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(model.list[index].desc,style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                  Text(model.list[index].statusText,
                    style: TextStyle(
                      color: model.list[index].status == 2
                        ? Color(0xffeaaf4c)
                        : Colors.red,fontSize: ScreenUtil().setSp(14)))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight:Radius.circular(5))
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15),ScreenUtil().setWidth(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: Text(model.list[index].title)),
                        Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),
                          width: 8, height: 16)
                      ],
                    ),
                  ),
                  Container(height: 0.5, color: Colors.grey[300],margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15))),
                  Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          model.list[index].time,
                          style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)),
                        ),
                        Offstage(
                          offstage: model.list[index].status == 2,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(12),1,ScreenUtil().setWidth(12),1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                              Border.all(color: Color(0xff999999), width: 1),
                              borderRadius: BorderRadius.circular(5)),
                            child: GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialogAlert(
                                    content: '是否确认删除？',
                                    onPressed: () => model.remove(index)
                                  );
                                }),
                              child: Text('删除',style: TextStyle(fontSize: ScreenUtil().setSp(13)))),
                          ),
                        ),
                      ]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
