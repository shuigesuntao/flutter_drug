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

class TakePrescriptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TakePrescriptionPageState();

}

class _TakePrescriptionPageState extends State<TakePrescriptionPage>{
  int wayChecked = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '拍方上传'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            color: Color(0xffe56068),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '上传照片必须包含以下信息',
                  style: TextStyle(color: Colors.white,fontSize: 12),
                ),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '患者信息：手机号、姓名、性别、年龄',
                      style: TextStyle(color: Colors.white,fontSize: 12),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '处方信息：辨病辨证、处方、用法用量、医生签名',
                      style: TextStyle(color: Colors.white,fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.fromLTRB(20,10,20,10),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('icon_xzyf_small.png'),width: 15,height: 15),
                        SizedBox(width: 10),
                        Text(
                          '选择药房',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ProviderWidget<CategoryModel>(
                  model: CategoryModel(),
                  onModelReady: (model) => model.initData(),
                  builder: (context,model,child) =>
                  model.busy? SizedBox():Column(
                    children: <Widget>[
                      DrugStoreItem(),
                      Offstage(
                        offstage: model.currentCategory != 0,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Divider(height: 0.5,color: Colors.grey[400]),
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Expanded(child: Text('煎药方式')),
                                Row(
                                  children: <Widget>[
                                    _buildWayButton(0, '自煎'),
                                    SizedBox(width: 10),
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
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.fromLTRB(20,10,20,10),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(ImageHelper.wrapAssets('icon_pfsc_small.png'),width: 15,height: 15),
                    SizedBox(width: 10),
                    Text(
                      '拍方上传',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 15),
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
                            width: 110,
                            height: 110,
                          ) : _buildImageItem(model),
                        );
                      }),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.prescriptionSample),
                      child: Image.asset(
                        ImageHelper.wrapAssets('ic_sample.png'),
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.grey[700],fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: '毒麻药材',
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12)),
                      TextSpan(
                        text: '用量必须符合药典规范；',
                        style: TextStyle(color: Colors.grey[700],fontSize: 12),
                      )
                    ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('*上传照片请保证清晰可见，如手写处方请保证字迹清晰；',style: TextStyle(color: Colors.grey[700],fontSize: 12)),
                ),
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.grey[700],fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: '1次',
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12)),
                      TextSpan(
                        text: '只可上传',
                        style: TextStyle(color: Colors.grey[700],fontSize: 12),
                      ),
                      TextSpan(
                        text: '1张',
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12)),
                      TextSpan(
                        text: '处方。',
                        style: TextStyle(color: Colors.grey[700],fontSize: 12),
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme
                      .of(context)
                      .primaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(
                    '上传处方划价',
                    style: TextStyle(color: Colors.white),
                  )
                ),
              ),bottom: true),
            )
          )
        ],
      )
    );
  }

  Widget _buildWayButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => wayChecked = index),
      child: SizedBox(
        width: 50,
        height: 20,
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(
              fontSize: 13,
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
          width: 110,
          height: 110,
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 0,
          right: 0,
          child:InkWell(
            onTap: ()=> model.image = null,
            child: Image.asset(ImageHelper.wrapAssets('icon_delete.png'),width: 20,height: 20),
          )
        )
      ],
    );
  }

}




