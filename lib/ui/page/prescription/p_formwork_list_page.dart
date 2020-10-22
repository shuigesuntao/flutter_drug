import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/prescription_formwork.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' hide BuildContext;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PrescriptionFormWorkListPage extends StatefulWidget {
  final int status;
  final bool hasHistory;

  PrescriptionFormWorkListPage(this.status,{this.hasHistory = false});


  @override
  State<StatefulWidget> createState() => _PrescriptionFormWorkListPageState();

}

class _PrescriptionFormWorkListPageState extends State<PrescriptionFormWorkListPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<PrescriptionFormWorkListModel>(
      model: PrescriptionFormWorkListModel(widget.status),
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
              return PrescriptionFormWorkItem(model.list[index],hasHistory:widget.hasHistory);
            }
          )
        );
      },
    );
  }
}


class PrescriptionFormWorkItem extends StatelessWidget {
  final PrescriptionFormWork p;
  final bool hasHistory;
  PrescriptionFormWorkItem(this.p,{this.hasHistory});
  @override
  Widget build(BuildContext context) {
    return Consumer<PrescriptionFormWorkListModel>(builder: (context,model,child){
      return GestureDetector(
        onTap: (){
          if(hasHistory){
            Navigator.pop(context,p.drugs);
          }else{
            Navigator.of(context).pushNamed(RouteName.formWorkDetail,arguments: p).then((id){
              model.list.removeWhere((p)=>p.id == id);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(10),ScreenUtil().setWidth(15),0),
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(p.name,style: TextStyle(fontWeight:FontWeight.bold,fontSize: ScreenUtil().setSp(16))),
                    Expanded(
                      child:SizedBox()
                    ),
                    Offstage(
                      offstage: p.status == 1,
                      child: Text('经典方',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(13))),
                    )
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Text(_getDrugsText(p.drugs),style: TextStyle(height: 1.5,color: Colors.grey[700],fontSize: ScreenUtil().setSp(14)))
              ],
            ),
          )
        ),
      );
    });
  }

  String _getDrugsText(List<Drug> drugs){
    if(drugs.length > 6) {
      return drugs.sublist(0,6).map((drug)=>'${drug.name}${drug.count}${drug.unit}').toList().join('   ') + '   等${drugs.length}味药材';
    }else {
      return drugs.map((drug)=>'${drug.name}${drug.count}${drug.unit}').toList().join(' ');
    }
  }
}
