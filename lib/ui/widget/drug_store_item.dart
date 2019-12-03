import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'dialog_drug_category.dart';

class DrugStoreItem extends StatelessWidget {
  final List drugs;

  DrugStoreItem({this.drugs});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryModel>(
        builder: (context, model, child) => Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: model.list[model.selectedCategory].imageUrl,
                  errorWidget: (context, url, error) => Image.asset(
                      ImageHelper.wrapAssets('tangji.png'),
                      width: 45,
                      height: 45),
                  fit: BoxFit.fill,
                  width: 45,
                  height: 45,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${model.list[model.selectedCategory].child[model.selectedDrugStore].name}-${model.list[model.selectedCategory].name}',
                              style: TextStyle(
                                fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Offstage(
                              offstage: drugs == null,
                              child: GestureDetector(
                                onTap: () {
                                  if (drugs.isEmpty) {
                                    showToast('请先编辑药材');
                                  } else {
                                    Navigator.of(context).pushNamed(
                                        RouteName.singleDrugPriceDetail,
                                        arguments: drugs);
                                  }
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                        '每剂：${getSinglePrice(drugs) == 0 ? '- -' : '￥${getSinglePrice(drugs)}'}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey))),
                              ),
                            )
                          ],
                        ))),
                GestureDetector(
                  child: Container(
                      width: 70,
                      height: 23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1)),
                      child: Center(
                        child: Text(
                          '更换剂型',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor,fontSize: 13),
                        ),
                      )),
                  onTap: () => showBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) =>
                          ChangeNotifierProvider<CategoryModel>.value(
                              value: model,
                              child: DialogDrugCategory(
                                  price: getSinglePrice(drugs)))),
                ),
              ],
            ));
  }

  double getSinglePrice(List<Drug> drugs) {
    return drugs == null ? 0 : double.parse((drugs.fold(0, (pre, e) => (pre + e.price * e.count))).toStringAsFixed(4));
  }
}
