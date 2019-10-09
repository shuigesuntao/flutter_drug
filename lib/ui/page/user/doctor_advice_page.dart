import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/doctor_advice_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class DoctorAdvicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, '医嘱管理', actionText: '新建医嘱',
            onActionPress: () {
              Navigator.of(context).pushNamed(
                RouteName.editDoctorAdvice,
                arguments: null);
        }),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: _controller,
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                          fillColor: Colors.white,
                          hintText: '请输入搜索信息',
                          hintStyle: TextStyle(
                              fontSize: 16, color: Color(0xFFcccccc))),
                      onSubmitted: (text) {
                        print(text);
                      },
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset(
                        ImageHelper.wrapAssets('new_fangdajing.png'),
                        width: 40,
                        height: 40),
                  )
                ],
              ),
              Expanded(
                  child: ProviderWidget<DoctorAdviceModel>(
                      model: DoctorAdviceModel(),
                      onModelReady: (model) {
                        model.initData();
                      },
                      builder: (context, model, child) {
                        return EasyRefresh(
                          controller: model.refreshController,
                          onRefresh: model.refresh,
                          enableControlFinishRefresh: true,
                          firstRefresh: true,
                          firstRefreshWidget:
                              Center(child: CircularProgressIndicator()),
                          emptyWidget:
                              model.empty ? ViewStateEmptyWidget() : null,
                          child: ListView.builder(
                            itemCount: model.list?.length ?? 0,
                            itemBuilder: (context, index) {
                              return _buildDoctorAdviceItem(
                                  context, index, model);
                            },
                          ),
                        );
                      }))
            ],
          ),
        ));
  }

  Widget _buildDoctorAdviceItem(
      BuildContext context, int index, DoctorAdviceModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(
          RouteName.editDoctorAdvice,
          arguments: model.list[index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey[300])),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(ImageHelper.wrapAssets('typeyp.png'),
                width: 40, height: 40)),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      model.list[index].content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(height: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '创建于:${model.list[index].createTime}',
                          style: TextStyle(color: Colors.grey),
                        )),
                      SizedBox(
                        width: 75,
                        height: 28,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () => model.setTop(
                            index, model.list[index].top == 0 ? 1 : 0),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            model.list[index].top == 0 ? '置顶' : '取消置顶',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        width: 75,
                        height: 28,
                        child: OutlineButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return DialogAlert(
                                content: '您确定要删除医嘱吗？',
                                onPressed: () {
                                  model.remove(index);
                                  Navigator.maybePop(context);
                                },
                              );
                            }),
                          color: Colors.white,
                          child: Text(
                            '删除',
                            style:
                            TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
