import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_drug_category.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class EditDrugPage extends StatefulWidget {

  final List<Drug> drugs;

  EditDrugPage({this.drugs});

  @override
  State<StatefulWidget> createState() => _EditDrugPageState(drugs);
}

class _EditDrugPageState extends State<EditDrugPage> {
  List<Drug> drugs;
  List<TextEditingController> _controllers = List();

  _EditDrugPageState(this.drugs);

  @override
  void initState() {
    super.initState();
    refreshDrugs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditDrugAppBar(drugs: drugs,onClear: ()=> setState(()=>drugs.clear())),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: GridView.count(
          //水平子Widget之间间距
          crossAxisSpacing: 15,
          //垂直子Widget之间间距
          mainAxisSpacing: 10,
          //GridView内边距
          padding: EdgeInsets.all(15),
          //一行的Widget数量
          crossAxisCount: 2,
          //子Widget宽高比例
          childAspectRatio: 3,
          //子Widget列表
          children: _buildEditDrugList(),
        )),
    );
  }

  List<Widget> _buildEditDrugList() {
    List<Widget> widgets = drugs.asMap().keys.map((index) {
      return _buildEditDrugItem(_controllers[index],index,drugs[index]);
    }).toList();
    widgets.add(_buildEditDrugItem(TextEditingController(),drugs.length,null));
    return widgets;
  }

  Widget _buildEditDrugItem(TextEditingController controller,int index,Drug drug) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(drug == null ? '请输入药材简拼' : drug.name,
                      style: TextStyle(
                          color: drug == null ? Colors.grey[300] : null))),
              Offstage(
                  offstage: drug == null,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 28,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFcccccc),
                              )),
                          style: TextStyle(fontSize: 12),
                          onChanged: (text) {
                            if (int.parse(text) > 300) {
                              showToast('数量最大为300');
                              controller.text = '300';
                            }
                            drugs[index].count = int.parse(controller.text);
                          },
                        ),
                      ),
                      Text('克',style: TextStyle(color: Colors.grey,fontSize: 13),)
                    ],
                  ))
            ],
          ),
          SizedBox(height: 5),
          Offstage(
            offstage: drug == null,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text('煎法',
                        style:
                            TextStyle(color: Colors.grey, fontSize: 13))),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      drugs.remove(drug);
                    });
                  },
                  child: Image.asset(ImageHelper.wrapAssets('ic_guanbi.png'),
                      width: 15, height: 15),
                )
              ],
            ),
          ),
          Offstage(
            offstage: drug != null,
            child: Row(
              children: <Widget>[
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                    .pushNamed(RouteName.prescriptionFormWork,
                    arguments: true)
                    .then((data) {
                    if (data != null) {
                      setState(() {
                        drugs = data;
                        refreshDrugs();
                      });
                    }
                  }),
                  child: Text('处方模板',
                    style: TextStyle(
                      color: Colors.blueAccent[400], fontSize: 13)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void refreshDrugs() {
    _controllers.clear();
    drugs.forEach((drug){
      TextEditingController c = TextEditingController(text: drug == null
        ? ''
        : '${drug.unitCount == null ? drug.count : drug.unitCount}');
      _controllers.add(c);
    });
  }
}

class EditDrugAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Drug> drugs;
  final VoidCallback onClear;

  EditDrugAppBar({this.drugs,this.onClear});
  @override
  State<StatefulWidget> createState() => _EditDrugAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _EditDrugAppBarState extends State<EditDrugAppBar> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryModel>(
      builder: (context, model, child) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            top: true,
            child: Stack(
              children: <Widget>[
                Positioned(child: Container(
                  width: 44,
                  padding: EdgeInsets.all(0),
                  child: new IconButton(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    icon: Image.asset(
                      ImageHelper.wrapAssets('ic_back_black.png'),
                      fit: BoxFit.contain,
                      width: 16,
                      height: 16,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(widget.drugs.isNotEmpty){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogAlert(
                              content: '是否保存当前处方？',
                              onPressed: () {
                                Navigator.maybePop(context);
                                Navigator.of(context).pop(widget.drugs);
                              },
                              onCancelPressed: (){
                                Navigator.maybePop(context);
                              },
                            );
                          });
                      }else{
                        Navigator.maybePop(context);
                      }
                    },
                  ),
                ),left: 1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(child: SizedBox()),
                        Expanded(flex:2,child: GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => ChangeNotifierProvider<
                                CategoryModel>.value(
                                value: model,
                                child: DialogDrugCategory(
                                  price: getSinglePrice(widget.drugs))));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                '${model.list[model.selectedCategory].child[model.selectedDrugStore].name}-${model.list[model.selectedCategory].name}',
                                style: TextStyle(
                                  fontSize: 16, color: Colors.black)),
                              Icon(Icons.keyboard_arrow_down,
                                color: Colors.black54),
                            ],
                          ))),
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogAlert(
                                    title: '提示',
                                    content: '是否清空所有已编辑药材',
                                    onPressed: () {
                                      widget.onClear();
                                      Navigator.maybePop(context);
                                    },
                                  );
                                }),
                              child: Center(
                                child: Image.asset(
                                  ImageHelper.wrapAssets('icon_more.png'),
                                  width: 18,
                                  height: 5),
                              ),
                            ),
                            SizedBox(width: 15),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(widget.drugs),
                                child: Center(
                                  child: Text(
                                    '完成',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              )),
                          ],
                        ))
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: ()=> Navigator.of(context).pushNamed(RouteName.singleDrugPriceDetail,arguments: widget.drugs),
                          child: Text(
                            '共 ${widget.drugs.length} 味，每剂 ${(widget.drugs.fold(0, (pre, e) => (pre + e.price * e.count))).toStringAsFixed(4)} 元，重 ${widget.drugs.fold(0, (pre, e) => pre + (e.unitCount == null ? e.count : e.unitCount))}克，详情',
                            style:
                            TextStyle(fontSize: 12, color: Color(0xffeaaf4c)))
                          ,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ));
      },
    );
  }

  double getSinglePrice(List<Drug> drugs) {
    return drugs.fold(0, (pre, e) => (pre + e.price * e.count));
  }
}
