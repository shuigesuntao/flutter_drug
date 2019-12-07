
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/disease.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_input.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/good_at_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class EditGoodAtPage extends StatefulWidget{
  final String goodAt;

  EditGoodAtPage({this.goodAt});

  @override
  State<StatefulWidget> createState() => _EditGoodAtPageState(goodAt.split(','));

}

class _EditGoodAtPageState extends State<EditGoodAtPage>{
  List<String> goodAts;

  _EditGoodAtPageState(this.goodAts);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<GoodAtModel>(
      model: GoodAtModel(),
      onModelReady: (model){
        model.initData();
        model.goodAt = goodAts;
      },
      builder: (context,model,child){
        return Scaffold(
          appBar: TitleBar.buildCommonAppBar(context, '编辑擅长',actionText: '保存',onActionPress: (){
            if(goodAts.isEmpty){
              showToast('请选择擅长标签');
            }else{
              Navigator.of(context).pop(goodAts.join(','));
            }
          }),
          body: Column(
            children: <Widget>[
              Divider(height: 0.5,color: Colors.grey[400]),
              Container(
                padding: EdgeInsets.all(15),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('选择擅长治疗的疾病',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(14))),
                        Text('（最多选择10个）',style: TextStyle(color:Colors.grey,fontSize: ScreenUtil().setSp(14))),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setWidth(10)),
                    Wrap(
                      spacing: ScreenUtil().setWidth(12),
                      runSpacing:ScreenUtil().setWidth(10),
                      children: _buildGoodAtWidgets(context,model),
                    )
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:ScreenUtil().setWidth(15)),
                  color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (context, index) => _buildDiseaseItem(model,index),
                    itemCount: model.list.length
                  )
                ),
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                height:  ScreenUtil().setWidth(20),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildGoodAtWidgets(BuildContext context,GoodAtModel model) {
    List<Widget> widgets = List();
    widgets.add(
      GestureDetector(
        onTap: (){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomInputDialog(title:'请输入自定义擅长',hint:'最多可输入10个字',label:'擅长名称',onPressed: (text) {
                setState(() {
                  if(goodAts.length == 10){
                    showToast('最多只能选择10个标签');
                  }else if(goodAts.contains(text)){
                    showToast('该标签已存在');
                  }else{
                    goodAts.add(text);
                  }
                });
              });
            });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).primaryColor,width: 1)
          ),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
          height: ScreenUtil().setWidth(28),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(ImageHelper.wrapAssets('icon_tagadd.png'),width: ScreenUtil().setWidth(12),height: ScreenUtil().setWidth(12)),
              SizedBox(width: ScreenUtil().setWidth(5)),
              Text(
                '自定义擅长',
                style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Colors.white),
              )
            ],
          )
        ),
      )
    );
    widgets.addAll(
      goodAts
      .map((goodAt) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor,width: 1)
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
      height: ScreenUtil().setWidth(28),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$goodAt',
            style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Theme.of(context).primaryColor),
          ),
          SizedBox(width: ScreenUtil().setWidth(5)),
          GestureDetector(
            onTap: ()=> setState(() {
              goodAts.remove(goodAt);
            }),
            child: Image.asset(ImageHelper.wrapAssets('icon_close.png'),width: ScreenUtil().setWidth(10),height: ScreenUtil().setWidth(10)),
          )
        ],
      )
    )).toList()
    );
    return widgets;
  }

  Widget _buildDiseaseItem(GoodAtModel model,int index) {
    Disease disease = model.list[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            child: Text(disease.office,style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Colors.grey)),
          ),
          Wrap(
            spacing: ScreenUtil().setWidth(12),
            children: _buildDiseaseWidgets(model,disease.diseases),
          )
        ],
      ),
    );
  }

  List<Widget> _buildDiseaseWidgets(GoodAtModel model,List<String> diseases) {
    return  diseases
      .map((disease) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400],width: 1)
        ),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(11),ScreenUtil().setWidth(5),ScreenUtil().setWidth(11),ScreenUtil().setWidth(5)),
        child: GestureDetector(
          onTap: ()=> setState(() {
            if(goodAts.length == 10){
              showToast('最多只能选择10个标签');
            }else if(goodAts.contains(disease)){
              showToast('该标签已存在');
            }else{
              goodAts.add(disease);
            }
          }),
          child: Text(
            '$disease',
            style: TextStyle(fontSize: ScreenUtil().setSp(14)),
          ),
        ),
      )
    ).toList();
  }
}