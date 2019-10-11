import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_drug_category.dart';
import 'package:flutter_drug/ui/widget/dialog_image_picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:flutter_drug/view_model/take_prescription_model.dart';
import 'package:provider/provider.dart';

class TakePrescriptionPage extends StatelessWidget {
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
            color: Color(0xFFF3ECD0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '上传照片必须包含以下信息',
                  style: TextStyle(color: Color(0xFFBF2B3E)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: RichText(
                        text: TextSpan(
                          text: '患者信息：',
                          style: TextStyle(color: Colors.black87),
                          children: <TextSpan>[
                            TextSpan(
                              text: '手机号',
                              style: TextStyle(color: Color(0xFFBF2B3E))),
                            TextSpan(
                              text: '、姓名、性别、年龄',
                              style: TextStyle(color: Colors.black87),
                            )
                          ]),
                      ),
                    ),
                    Text(
                      '处方信息：辨病辨证、处方、用法用量、医生签名',
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child:
                      Container(width: 3, height: 3, color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '选择药房',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ClipOval(
                      child:
                      Container(width: 3, height: 3, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(height: 15),
                ProviderWidget<CategoryModel>(
                  model: CategoryModel(),
                  onModelReady: (model) => model.initData(),
                  builder: (context,model,child) =>
                    model.busy? SizedBox():DrugStoreItem(),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(15,0,15,15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child:
                      Container(width: 3, height: 3, color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '拍方上传',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ClipOval(
                      child:
                      Container(width: 3, height: 3, color: Colors.black),
                    )
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
                            ImageHelper.wrapAssets('ic_clickphotos.png'),
                            width: 120,
                            height: 120,
                          ) : _buildImageItem(model),
                        );
                      }),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.prescriptionSample),
                      child: Image.asset(
                        ImageHelper.wrapAssets('ic_sample.png'),
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.grey[700]),
                    children: <TextSpan>[
                      TextSpan(
                        text: '毒麻药材',
                        style: TextStyle(color: Color(0xFFBF2B3E))),
                      TextSpan(
                        text: '用量必须符合药典规范；',
                        style: TextStyle(color: Colors.grey[700]),
                      )
                    ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('*上传照片请保证清晰可见，如手写处方请保证字迹清晰；',style: TextStyle(color: Colors.grey[700]),),
                ),
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.grey[700]),
                    children: <TextSpan>[
                      TextSpan(
                        text: '1次',
                        style: TextStyle(color: Color(0xFFBF2B3E))),
                      TextSpan(
                        text: '只可上传',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextSpan(
                        text: '1张',
                        style: TextStyle(color: Color(0xFFBF2B3E))),
                      TextSpan(
                        text: '处方。',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => print("点击了上传处方划价"),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      '上传处方划价',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              )))
        ],
      )
    );
  }

  Widget _buildImageItem(TakePrescriptionModel model) {
      return Stack(
        children: <Widget>[
          Image.file(
            model.image,
            width: 120,
            height: 120,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 0,
            right: 0,
            child:InkWell(
              onTap: ()=> model.image = null,
              child: Image.asset(ImageHelper.wrapAssets('ic_delete.png'),width: 20,height: 20),
            )
          )
        ],
      );
  }
}

class DrugStoreItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryModel>(builder: (context,model,child) => Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: model.list[model.selectedCategory].imageUrl,
          errorWidget: (context, url, error) => Image.asset(ImageHelper.wrapAssets('tangji.png'), width: 50, height: 50),
          fit: BoxFit.fill,
          width: 50,
          height: 50,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '${model.list[model.selectedCategory].child[model.selectedDrugStore].name}-${model.list[model.selectedCategory].name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
        SizedBox(
          width: 60,
          height: 30,
          child: OutlineButton(
            onPressed: (){
              showBottomSheet(
                backgroundColor:Colors.transparent,
                context: context,
                builder: (context) => ChangeNotifierProvider<CategoryModel>.value(value: model,child: DialogDrugCategory())
              );
            },
            color: Colors.white,
            child: Text(
              '更换',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3))),
          ),
        ),
      ],
    ));
  }

}


