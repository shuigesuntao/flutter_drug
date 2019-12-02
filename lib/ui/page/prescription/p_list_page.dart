import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/prescription.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_alert.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
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
        if (model.busy) {
          return Center(child: CircularProgressIndicator());
        } else if (model.error) {
          return ViewStateWidget(onPressed: model.initData);
        }
        return SmartRefresher(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          enablePullUp: !model.empty ,
          child: model.empty ? ViewStateEmptyWidget(image: 'zwdd.png',message: '暂无订单',) :ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              return _buildPrescriptionItem(model,index);
            }));
      },
    );
  }

  Widget _buildPrescriptionItem(PrescriptionListModel model,int index){
    Prescription p = model.list[index];
    return Padding(
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
                Text(p.name),
                Text(' ${p.gender} ${p.age}岁',style: TextStyle(color: Colors.grey[700])),
                Expanded(child: SizedBox()),
                Text(p.statusText,style: TextStyle(color: p.status == 4?Colors.grey:Colors.redAccent))
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
                          Text('【诊断】${p.symptom}',maxLines: 1,overflow: TextOverflow.ellipsis),
                          SizedBox(height: 10),
                          Text('【药费】￥${p.price}')
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
                        style: TextStyle(color: Colors.grey,fontSize: 12),
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
                                  onPressed: () => model.remove(index)
                                );
                              }),
                            child: Text('删除',style: TextStyle(fontSize: 13),)),
                        ),
                      ),
                    ]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}