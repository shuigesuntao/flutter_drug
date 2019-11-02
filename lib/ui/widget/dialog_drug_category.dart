import 'package:flutter/material.dart';
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
          height: 550,
          child: Consumer<CategoryModel>(builder: (context,model,child) => Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('选择药房及处方剂型')),
                    GestureDetector(
                      child: Text('确定',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor)),
                      onTap: () {
                        model.selectedCategory = model.currentCategory;
                        model.selectedDrugStore = model.currentDrugStore;
                        Navigator.maybePop(context);
                      })
                  ],
                ),
                color: Colors.grey[200],
                padding: EdgeInsets.fromLTRB(20,15,20,15),
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
              border: Border.all(
                  width: 1,
                  color: model.currentDrugStore == i
                      ? Theme.of(context).primaryColor
                      : Colors.transparent)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Text(data.name, style: TextStyle(fontWeight: FontWeight.w500))),
                  Offstage(
                    offstage: price==0,
                    child: Text('【每剂￥$price】'),
                  )
                ],
              ),
              SizedBox(height: 5),
              Text(data.label, style: TextStyle(color: Colors.grey,fontSize: 13)),
              SizedBox(height: 5),
              Text(data.desc, style: TextStyle(color: Colors.grey,fontSize: 13))
            ],
          ),
        ));
  }
}
