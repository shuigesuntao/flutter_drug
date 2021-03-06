import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_input.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/decoct_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DecoctManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DecoctModel>(
        model: DecoctModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: TitleBar.buildCommonAppBar(context, '入煎方法管理',
                  actionText: model.isDelete ? '完成' : '删除',
                  onActionPress: () => model.changeDeleteMode()),
              body: Column(
                children: <Widget>[
                  Expanded(child: _buildBody(model)),
                  Offstage(
                      offstage: model.isDelete,
                      child: SafeArea(
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CustomInputDialog(title:'自定义入煎方法',hint:'请输入入煎方法',label:'煎法名称',onPressed: (text) {
                                  model.add(text);
                                });
                              }),
                          child: Container(
                              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), 0),
                              width: double.infinity,
                              height: ScreenUtil().setWidth(40),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                '新增入煎方法',
                                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
                              )
                          ),
                        ),
                        bottom: true,
                      )),
                  SizedBox(height: ScreenUtil().setWidth(10))
                ],
              ));
        });
  }

  _buildBody(DecoctModel model) {
    if (model.isBusy) {
      return Center(child: CircularProgressIndicator());
    } else if (model.isError) {
      return ViewStateWidget(onPressed: model.initData);
    }
    return SmartRefresher(
      controller: model.refreshController,
      onRefresh: model.refresh,
      child: model.isEmpty
          ? ViewStateEmptyWidget()
          : ListView.builder(
              itemCount: model.list?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), 0),
                    child: Row(
                      children: <Widget>[
                        Offstage(
                          offstage: !model.isDelete,
                          child: GestureDetector(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialogAlert(
                                    content: '是否删除该入煎方法',
                                    onPressed: () => model.remove(index)
                                  );
                                }),
                            child: Padding(
                                padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                                child: Image.asset(
                                    ImageHelper.wrapAssets(
                                        'icon_delete_cicle.png'),
                                    width: ScreenUtil().setWidth(20),
                                    height: ScreenUtil().setWidth(20))),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),ScreenUtil().setWidth(12),ScreenUtil().setWidth(10),ScreenUtil().setWidth(12)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Text(model.list[index].name),
                        ))
                      ],
                    ));
              },
            ),
    );
  }
}
