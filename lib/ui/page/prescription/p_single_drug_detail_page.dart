
import 'package:flutter/material.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingeDrugDetailPage extends StatelessWidget{

  final List<Drug> drugs;

  SingeDrugDetailPage({this.drugs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '药材明细'),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            color: Color(0x26eedd8f),
            child: Text('共 ${drugs.length} 味药材，每剂重 ${drugs.fold(0, (pre,e)=>pre+(e.unitCount==null?e.count:e.unitCount))} 克，每剂 ${drugs.fold(0, (pre, e) => (pre + e.price * e.count))} 元',
              style: TextStyle(color: Color(0xffeaaf4c),fontSize:  ScreenUtil().setSp(12))),
          ),
          Expanded(child: ListView.separated(
            separatorBuilder: (context,index) => Divider(height: 0.5,color: Colors.grey[400]),
            itemCount: drugs.length,
            itemBuilder: (context, index) => _buildDrugPriceItem(index)
          )),
          SafeArea(
            child: GestureDetector(
              onTap: ()=> Navigator.of(context).pop(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                height: ScreenUtil().setWidth(40),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                decoration: BoxDecoration(
                  color: Theme
                    .of(context)
                    .primaryColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  '返回上一页',
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
                )
              ),
            ),
            bottom: true)
        ],
      ),
    );
  }

  Widget _buildDrugPriceItem(int index) {
    Drug drug = drugs[index];
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Text('${index + 1}）',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                Text(drug.name, style: TextStyle(fontSize: ScreenUtil().setSp(14))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(child:Text('${drug.unitCount==null?drug.count:drug.unitCount}克 x ${drug.price}',style: TextStyle(fontSize: ScreenUtil().setSp(13))))
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text('${((drug.unitCount==null?drug.count:drug.unitCount)*drug.price).toStringAsFixed(4)}元',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
            )
          )
        ],
      ),
    );
  }

}