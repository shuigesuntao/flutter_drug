import 'package:flutter/material.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/prescription_formwork.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PrescriptionFormWorkListPage extends StatelessWidget {
  final int status;

  PrescriptionFormWorkListPage(this.status);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PrescriptionFormWorkListModel>(
      model: PrescriptionFormWorkListModel(status),
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
            Text(p.name,style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Text(_getDrugsText(p.drugs))
          ],
        ),
      )
    );
  }

  String _getDrugsText(List<Drug> drugs){
    if(drugs.length > 6) {
      return drugs.sublist(0,6).map((drug)=>'${drug.name}${drug.count}${drug.unit}').toList().join(' ') + '等${drugs.length}味药材';
    }else {
      return drugs.map((drug)=>'${drug.name}${drug.count}${drug.unit}').toList().join(' ');
    }
  }
}
