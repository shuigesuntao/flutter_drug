
import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectOfficePage extends StatelessWidget{

  final String office;

  SelectOfficePage({this.office});

  final List<String> offices = ['心脑血管科','消化科','妇科','肾病科',
    '皮肤科','肿瘤科','呼吸科','肝胆科','男科','内分泌科',
    '神经科','疼痛科','内科','儿科','五官科','骨科',
    '血液科','针灸科','疼痛科','传染病科','身心科','全科',
    '心理科','心内科','眼科','耳鼻喉科','风湿免疫科','肛肠科',
    '外科','口腔科','周围血管科','治未病科','泌尿外科','乳腺科',
    '疮疡科','老年病科','生殖科','康复科','三部六病科','中医疑难病科',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.buildCommonAppBar(context, '科室分类'),
      body: Column(
        children: <Widget>[
          Divider(height: 0.5,color: Colors.grey[400]),
          Expanded(child:
            SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
                  child: Text('请选择您所在的科室',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor)),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //水平子Widget之间间距
                  crossAxisSpacing: 15,
                  //垂直子Widget之间间距
                  mainAxisSpacing: ScreenUtil().setWidth(20),
                  //GridView内边距
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                  //一行的Widget数量
                  crossAxisCount: 3,
                  //子Widget宽高比例
                  childAspectRatio: 3,
                  //子Widget列表
                  children: _buildOfficeItems(context)
                ),
                SafeArea(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('*如果没有符合的科室，请拨打客服电话',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey)),
                      Text('420-520-120',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor)),
                    ],
                  )
                ),bottom: true),
                SizedBox(height: ScreenUtil().setWidth(10))
              ],
            ),
          )
          )
        ],
      )
    );
  }

  List<Widget> _buildOfficeItems(BuildContext context) {
    return offices.map((office)=>
      GestureDetector(
        onTap: ()=> Navigator.of(context).pop(office),
        child: Container(
          decoration: BoxDecoration(
            color: this.office == office? Theme.of(context).primaryColor:Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1,color: this.office == office? Theme.of(context).primaryColor:Colors.grey[600])
          ),
          child: Center(
            child: Text(office,style: TextStyle(color: this.office == office? Colors.white:null,fontSize: ScreenUtil().setSp(13))),
          ),
        ),
      )
    ).toList();
  }

}