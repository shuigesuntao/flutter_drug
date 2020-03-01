import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/event/event_bus.dart';
import 'package:flutter_drug/event/event_model.dart';
import 'package:flutter_drug/model/prescription.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_alert.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PrescriptionListPage extends StatefulWidget{
  final int status;

  PrescriptionListPage(this.status);
  @override
  State<StatefulWidget> createState() => _PrescriptionListPageState();

}

class _PrescriptionListPageState extends State<PrescriptionListPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<PrescriptionListModel>(
      model: PrescriptionListModel(widget.status),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return Center(child: CircularProgressIndicator());
        } else if (model.isError) {
          return ViewStateWidget(onPressed: model.initData);
        }
        if(widget.status == 0){
          ApplicationEvent.event.fire(AlreadyPrescriptionCountEvent(model.list.length,model.list.where((p)=>p.status == 1).length));
        }
        return SmartRefresher(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          enablePullUp: !model.isEmpty ,
          child: model.isEmpty ? ViewStateEmptyWidget(image: 'zwdd.png',message: '暂无订单',) :ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              return PrescriptionItem(model,model.list[index]);
            }));
      },
    );
  }
}

class PrescriptionItem extends StatelessWidget{

   final PrescriptionListModel model;
   final Prescription p;

  PrescriptionItem(this.model,this.p);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(p.status == 1){
          //未付款
          Navigator.of(context).pushNamed(RouteName.orderDetail, arguments: 0);
        }else if(p.status == 4){
          //已完成
          Navigator.of(context).pushNamed(RouteName.finishOrderDetail);
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff9f9f9),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5))
              ),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: <Widget>[
                  Text(p.name,style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  Text(' ${p.gender} ${p.age}岁',style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(14))),
                  Expanded(child: SizedBox()),
                  Text(p.statusText,style: TextStyle(color: p.status == 4?Colors.grey:Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14)))
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
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('【诊断】${p.symptom}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                            SizedBox(height: 10),
                            Text('【药费】￥${p.price}',style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                          ],
                        )),
                        SizedBox(width: 10),
                        Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),
                          width: 8, height: 16)
                      ],
                    ),
                  ),
                  Container(height: 0.5, color: Colors.grey[300],margin: EdgeInsets.symmetric(horizontal: 15)),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          p.time,
                          style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)),
                        ),
                        Offstage(
                          offstage: p.status == 4,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12,1,12,1),
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
                                    onPressed: () => model.remove(p)
                                  );
                                }),
                              child: Text('删除',style: TextStyle(fontSize: ScreenUtil().setSp(13)))),
                          ),
                        ),
                      ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}