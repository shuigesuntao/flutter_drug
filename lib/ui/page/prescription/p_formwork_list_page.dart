import 'package:flutter/material.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/prescription_formwork.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PrescriptionFormWorkListPage extends StatefulWidget {
  final int status;

  PrescriptionFormWorkListPage(this.status);


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
        if (model.busy) {
          return Center(child: CircularProgressIndicator());
        }
        return EasyRefresh(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoad: model.loadMore,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          emptyWidget: model.empty ? ViewStateEmptyWidget() : null,
          child: ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              return PrescriptionFormWorkItem(model.list[index]);
            }
          )
        );
      },
    );
  }



}


class PrescriptionFormWorkItem extends StatelessWidget {
  final PrescriptionFormWork p;
  PrescriptionFormWorkItem(this.p);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15,10,15,0),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(p.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Expanded(
                  child:SizedBox()
                ),
                Offstage(
                  offstage: p.status == 1,
                  child: Text('经典方',style: TextStyle(color: Colors.grey),),
                )
              ],
            ),
            SizedBox(height: 10),
            Text(_getDrugsText(p.drugs),style: TextStyle(height: 1.5))
          ],
        ),
      )
    );
  }

  String _getDrugsText(List<Drug> drugs){
    if(drugs.length > 6) {
      return drugs.sublist(0,6).map((drug)=>'${drug.name}${drug.count}${drug.unit}').toList().join('   ') + '   等${drugs.length}味药材';
    }else {
      return drugs.map((drug)=>'${drug.name}${drug.count}${drug.unit}').toList().join(' ');
    }
  }
}
