

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/model/prescription.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
              return _buildPrescriptionItem(model.list[index]);
            }));
      },
    );
  }


  Widget _buildPrescriptionItem(Prescription p){
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(15),child:
          Row(
            children: <Widget>[
              Text(p.name),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child: Text(p.gender),),
              Text('${p.age}岁'),
              Expanded(child: SizedBox()),
              Text(p.statusText,style: TextStyle(color: p.status == 4?Colors.grey:Colors.redAccent),)
            ],
          ),),
          Divider(height: 1,color: Colors.grey,indent: 15,),
          Padding(padding: EdgeInsets.all(15),child:
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(p.symptom),
                        SizedBox(height: 10),
                        Text(p.time,style: TextStyle(color: Colors.grey),),

                      ],
                    ),),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                Offstage(
                  offstage: p.status == 4,
                  child:  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 60,
                      height: 30,
                      child: OutlineButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('提示'),
                              content: Text('您确定删除吗？'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text("取消"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text("确定"),
                                  onPressed: () {
                                    print('删除');
                                  },
                                ),
                              ],
                            );
                          }),
                        color: Colors.white,
                        child: Text(
                          '删除',
                          style: TextStyle(color: Colors.grey),
                        ),
                        borderSide:
                        BorderSide(color:Colors.grey, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                    ),
                  ),
                )
              ],
            ),
           )
        ],
      ),
    );
  }
}