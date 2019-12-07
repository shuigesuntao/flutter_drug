import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/doctor_advice_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DoctorAdvicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorAdvicePageState();

}

class _DoctorAdvicePageState extends State<DoctorAdvicePage>{

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, '医嘱管理'),
        body: Padding(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(5), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(-ScreenUtil().setWidth(20), ScreenUtil().setWidth(5), ScreenUtil().setWidth(10), ScreenUtil().setWidth(5)),
                    border: InputBorder.none,
                    icon: Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(5), ScreenUtil().setWidth(15), ScreenUtil().setWidth(5)),
                      child: Image.asset(
                        ImageHelper.wrapAssets('icon_sousuo.png'),
                        width: ScreenUtil().setWidth(14),
                        height: ScreenUtil().setWidth(14)),
                    ),
                    hintText: '请输入搜索信息',
                    hintStyle:
                    TextStyle(fontSize: ScreenUtil().setSp(14), color: Colors.grey[350])),
                  onSubmitted: (text) {
                    print(text);
                  },
                ),
              ),
              Expanded(
                child: ProviderWidget<DoctorAdviceModel>(
                  model: DoctorAdviceModel(),
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
                      enablePullUp: true,
                      child: model.empty
                        ? ViewStateEmptyWidget()
                        : ListView.builder(
                        itemCount: model.list?.length ?? 0,
                        itemBuilder: (context, index) {
                          return _buildDoctorAdviceItem(
                            context, index, model);
                        },
                      ),
                    );
                  })
              ),
              SafeArea(child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  RouteName.editDoctorAdvice,
                  arguments: null),
                child: Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    '新建医嘱',
                    style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
                  )),
              ),bottom: true)
            ],
          ),
        )),
    );
  }

  Widget _buildDoctorAdviceItem(
    BuildContext context, int index, DoctorAdviceModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.editDoctorAdvice,
          arguments: model.list[index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.grey[300])),
        child: Padding(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.list[index].content,
              ),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Text(
                '创建于:${model.list[index].createTime}',
                style: TextStyle(color: Colors.grey[600], fontSize: ScreenUtil().setSp(12)),
              ),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Divider(height: 0.5, color: Colors.grey[400]),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => model.setTop(
                      index, model.list[index].top == 0 ? 1 : 0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets(model.list[index].top == 0
                            ? 'icon_xz.png'
                            : 'icon_disselect.png'),
                          width: ScreenUtil().setWidth(15),
                          height: ScreenUtil().setWidth(15)),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Text(model.list[index].top == 0 ? '取消置顶' : '设为置顶',
                          style:
                          TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(12)))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogAlert(
                          content: '是否删除该医嘱内容',
                          onPressed: () => model.remove(index)
                        );
                      }),
                    child: Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('delete_all.png'),
                          width: ScreenUtil().setWidth(15), height: ScreenUtil().setWidth(15)),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Text('删除',
                          style:
                          TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(12)))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
    );
  }
}
