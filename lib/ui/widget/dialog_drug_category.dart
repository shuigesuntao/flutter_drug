import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/category.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:provider/provider.dart';

class DialogDrugCategory extends StatelessWidget {
  final double price;

  DialogDrugCategory({this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Container(color: Colors.black54, height: double.infinity),
        ),
        Container(
          color: Colors.white,
          height: 520,
          child: Consumer<CategoryModel>(builder: (context,model,child) => Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('选择药房及处方剂型')),
                    GestureDetector(
                      child: Text('确定',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor)),
                      onTap: () {
                        model.selectedCategory = model.currentCategory;
                        model.selectedDrugStore = model.currentDrugStore;
                        Navigator.maybePop(context);
                      })
                  ],
                ),
                color: Colors.grey[200],
                padding: EdgeInsets.fromLTRB(20,12,20,12),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    new Container(
                      color: Colors.grey[200],
                      width: 100,
                      child: ListView.builder(
                        itemCount: model.list.length,
                        itemBuilder: (context, index) =>
                          _buildCategoryItem(model, index))),
                    new Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: ListView.builder(
                          itemCount: model
                            .list[model.currentCategory].child.length,
                          itemBuilder: (context, index) =>
                            _buildDrugStoreItem(
                              context, model, index)),
                      ))
                  ],
                )
              )
            ],
          ))
        )
      ],
    );
  }

  Widget _buildCategoryItem(CategoryModel model, int i) {
    return GestureDetector(
      onTap: () {
        if (model.currentCategory != i) {
          model.currentDrugStore = 0;
          model.currentCategory = i;
        }
      },
      child: Container(
          alignment: Alignment.center,
          child: Text(model.list[i].name),
          padding: EdgeInsets.symmetric(vertical: 15),
          color: model.currentCategory == i ? Colors.white : Colors.grey[200]),
    );
  }

  Widget _buildDrugStoreItem(BuildContext context, CategoryModel model, int i) {
    DrugStore data = model.list[model.currentCategory].child[i];
    return GestureDetector(
        onTap: () {
          model.currentDrugStore = i;
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Row(
                    children: <Widget>[
                      Text(data.name, style: TextStyle(fontWeight: FontWeight.w500)),
                      Offstage(
                        offstage: data.id !=1 && data.id !=2 && data.id != 3,
                        child: Container(
                          margin: EdgeInsets.only(left:2,bottom: 10),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left:2,bottom:2),
                          width: 52,
                          height: 18,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageHelper.wrapAssets('pzyc.png'))
                            )
                          ),
                          child: Text(data.id ==1 ?'特供药材':data.id == 2 ? '上乘药材' :data.id == 3 ? '中乘药材':'',style: TextStyle(fontSize: 10,color: Colors.white)),
                        ),
                      )
                    ],
                  )),
                  GestureDetector(
                    onTap: (){
                      Map map = Map();
                      map['title'] = '品牌介绍';
                      map['url'] = data.detailUrl;
                      map['share'] = false;
                      Navigator.of(context).pushNamed(RouteName.webView, arguments: map);
                    },
                    child: Text('查看详情',style: TextStyle(fontSize: 11,color: Color(0xff798fb7))),
                  )
                ],
              ),
              SizedBox(height: 5),
              Text(data.label, style: TextStyle(color: Colors.grey,fontSize: 13)),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(data.desc, style: TextStyle(color: Colors.grey,fontSize: 13)),
                  Image.asset(ImageHelper.wrapAssets(model.currentDrugStore == i?'icon_xz.png':'icon_wxz.png'),width: 18,height: 18)
                ],
              )

            ],
          ),
        ));
  }
}
