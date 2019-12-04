import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/prescription_formwork.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_input.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:oktoast/oktoast.dart';

import 'edit_drug_page.dart';
import 'edit_formwork_drug_page.dart';
import 'p_open_page.dart';

class PrescriptionFormWorkDetailPage extends StatefulWidget{

  final PrescriptionFormWork p;

  PrescriptionFormWorkDetailPage({this.p});

  @override
  State<StatefulWidget> createState() => _PrescriptionFormWorkDetailPageState(p);

}

class _PrescriptionFormWorkDetailPageState extends State<PrescriptionFormWorkDetailPage>{
  PrescriptionFormWork p;

  _PrescriptionFormWorkDetailPageState(this.p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, p.status == 1?'常用处方':'经方详情',actionTextColor: Colors.grey,
      actionText: p.status == 1?'删除':null,onActionPress: (){
          Navigator.of(context).pop(p.id);
      }),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.fromLTRB(15,10,15,10),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('处方名称',style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      SizedBox(height: 0.5),
                    ],
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        if(p.status == 1){
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CustomInputDialog(title:'请输入常用方名称',hint:'最多可输入20个字',content:p.name,label:'煎法名称',onPressed: (text) {
                                showToast('修改成功');
                                p.name = text;
                              });
                            });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(p.name),
                          SizedBox(height: 5),
                          Divider(height: 1,color: Colors.grey[400])
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('药材明细',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                  SizedBox(height: 15),
                  Text('R:',style: TextStyle(fontSize: 22)),
                  SizedBox(height: 5),
                  Stack(
                    children: <Widget>[
                      Image.asset(ImageHelper.wrapAssets('kuang_left.png'),width: 12,height: 12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        color: Color(0x26eedd8f),
                        child: Wrap(
                          spacing: 15,
                          children: _buildDrugWidgets(),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Image.asset(ImageHelper.wrapAssets('kuang_right.png'),width: 12,height: 12),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Offstage(
                    offstage: p.status != 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '共${p.drugs.length}味药，总重${(p.drugs.fold(0, (pre, e) => pre + (e.unitCount == null ? e.count : e.unitCount)))}克',
                          style: TextStyle(color: Colors.grey,fontSize: 13)),
                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                ImageHelper.wrapAssets('icon_bianjiyaocia.png'),
                                width: 15,
                                height: 15),
                              SizedBox(width: 2),
                              Text(
                                '编辑药材',
                                style:
                                TextStyle(color: Theme.of(context).primaryColor,fontSize: 15),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                  EditFormWorkDrugPage(
                                    drugs: p.drugs.map((drug)=>Drug(drug.name,drug.count)).toList()))).then((data) {
                              if (data != null) {
                                setState(() {
                                  p.drugs = data;
                                });
                              }
                            });
                          })
                      ],
                    ),
                  ),
                ],
              ) ,
            ),
            Expanded(child: Container(

              alignment: Alignment.bottomCenter,
              child: SafeArea(
                bottom: true,
                child: GestureDetector(
                  onTap: () =>
                    Navigator.push(context,CupertinoPageRoute(builder: (context)=>PrescriptionOpenPage(friend:null,isWeChat:false))),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme
                        .of(context)
                        .primaryColor,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      '使用处方',
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ),
              ),
            )),
            SizedBox(height: 10),
          ],
        ),
      )
    );
  }

  /// 药品列表
  List<Widget> _buildDrugWidgets() {
    return p.drugs
      .map((drug) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        '${drug.name}${drug.count}${drug.unit}',
        style: TextStyle(fontSize: 13),
      )))
      .toList();
  }

}