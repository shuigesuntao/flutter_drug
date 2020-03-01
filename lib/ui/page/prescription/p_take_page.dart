import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/drug_store_item.dart';
import 'package:flutter_drug/ui/widget/dialog_image_picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:flutter_drug/view_model/take_prescription_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TakePrescriptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TakePrescriptionPageState();

}

class _TakePrescriptionPageState extends State<TakePrescriptionPage>{
  int wayChecked = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '拍方上传'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            color: Color(0xffe56068),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '上传照片必须包含以下信息',
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(12)),
                ),
                SizedBox(height: ScreenUtil().setWidth(3)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '患者信息：手机号、姓名、性别、年龄',
                      style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(12)),
                    ),
                    SizedBox(height: ScreenUtil().setWidth(3)),
                    Text(
                      '处方信息：辨病辨证、处方、用法用量、医生签名',
                      style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(12)),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setWidth(15)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(10),ScreenUtil().setWidth(20),ScreenUtil().setWidth(10)),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('icon_xzyf_small.png'),width: ScreenUtil().setWidth(15),height: ScreenUtil().setWidth(15)),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Text(
                          '选择药房',
                          style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(15)),
                ProviderWidget<CategoryModel>(
                  model: CategoryModel(),
                  onModelReady: (model) => model.initData(),
                  builder: (context,model,child) =>
                  model.isBusy? SizedBox():Column(
                    children: <Widget>[
                      DrugStoreItem(),
                      Offstage(
                        offstage: model.currentCategory != 0,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Divider(height: 0.5,color: Colors.grey[400]),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Row(
                              children: <Widget>[
                                Expanded(child: Text('煎药方式')),
                                Row(
                                  children: <Widget>[
                                    _buildWayButton(0, '自煎'),
                                    SizedBox(width: ScreenUtil().setWidth(10)),
                                    _buildWayButton(1, '代煎')
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setWidth(15)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(10),ScreenUtil().setWidth(20),ScreenUtil().setWidth(20)),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(ImageHelper.wrapAssets('icon_pfsc_small.png'),width: ScreenUtil().setWidth(15),height: ScreenUtil().setWidth(15)),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Text(
                      '拍方上传',
                      style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProviderWidget<TakePrescriptionModel>(
                      model: TakePrescriptionModel(),
                      builder: (context,model,child){
                        return GestureDetector(
                          onTap: (){
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return DialogImagePicker(
                                  onImageSelected: (file) {
                                    model.image = file;
                                  },
                                );
                              }
                            );
                          },
                          child: model.image == null ? Image.asset(
                            ImageHelper.wrapAssets('icon_clikpotos.png'),
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setWidth(100),
                          ) : _buildImageItem(model),
                        );
                      }),
                    SizedBox(width: ScreenUtil().setWidth(20)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.prescriptionSample),
                      child: Image.asset(
                        ImageHelper.wrapAssets('ic_sample.png'),
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setWidth(100),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setWidth(15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(12)),
                    children: <TextSpan>[
                      TextSpan(
                        text: '毒麻药材',
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(12))),
                      TextSpan(
                        text: '用量必须符合药典规范；',
                        style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(12)),
                      )
                    ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                  child: Text('*上传照片请保证清晰可见，如手写处方请保证字迹清晰；',style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(12))),
                ),
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(12)),
                    children: <TextSpan>[
                      TextSpan(
                        text: '1次',
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(12))),
                      TextSpan(
                        text: '只可上传',
                        style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(12)),
                      ),
                      TextSpan(
                        text: '1张',
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(12))),
                      TextSpan(
                        text: '处方。',
                        style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(12)),
                      ),
                    ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(child:  GestureDetector(
                onTap: () => print("点击了上传处方划价"),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
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
                    '上传处方划价',
                    style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
                  )
                ),
              ),bottom: true),
            )
          ),
          SizedBox(height: ScreenUtil().setWidth(10))
        ],
      )
    );
  }

  Widget _buildWayButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => wayChecked = index),
      child: SizedBox(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(20),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(12),
              color: wayChecked == index ? Colors.white : Colors.grey[400])),
          decoration: BoxDecoration(
            border: wayChecked == index
              ? null
              : Border.all(color: Colors.grey[400], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: wayChecked == index
              ? Theme
              .of(context)
              .primaryColor
              : Colors.white),
        ),
      ),
    );
  }

  Widget _buildImageItem(TakePrescriptionModel model) {
    return Stack(
      children: <Widget>[
        Image.file(
          model.image,
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setWidth(100),
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 0,
          right: 0,
          child:InkWell(
            onTap: ()=> model.image = null,
            child: Image.asset(ImageHelper.wrapAssets('icon_delete.png'),width: ScreenUtil().setWidth(20),height: ScreenUtil().setWidth(20)),
          )
        )
      ],
    );
  }

}




