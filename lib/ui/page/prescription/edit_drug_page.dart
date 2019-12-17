import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/simple_drug.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/custom_edit_drug_keyboard.dart';
import 'package:flutter_drug/ui/widget/custom_letter_keyboard.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_drug_category.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:flutter_drug/view_model/search_drugs_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class EditDrugPage extends StatefulWidget {
  final List<Drug> drugs;

  EditDrugPage({this.drugs});

  @override
  State<StatefulWidget> createState() => _EditDrugPageState(List.generate(drugs.length, (index)=> drugs[index],growable: true));
}

class _EditDrugPageState extends State<EditDrugPage> {
  bool _isShow = false;
  List<Drug> drugs;
  List<TextEditingController> _countControllers = List();
  List<TextEditingController> _nameControllers = List();
  TextEditingController _newNameController = TextEditingController();
  TextEditingController _newCountController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _countFocusNode = FocusNode();

  _EditDrugPageState(this.drugs);

  @override
  void initState() {
    super.initState();
    refreshDrugs();
    _nameFocusNode.addListener(() {
      if (this.mounted) {
        // TextField has lost focus
        setState(() {
          _isShow = _nameFocusNode.hasFocus;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(child: Builder(builder: (ctx) {
      return Scaffold(
          appBar: EditDrugAppBar(
              drugs: drugs, onClear: () => setState((){
            drugs.clear();
            refreshDrugs();
          })),
          body: ProviderWidget<SearchDrugsModel>(
            model: SearchDrugsModel(),
            builder: (context,model,child){
              return Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                    child: GridView.count(
                      //水平子Widget之间间距
                      crossAxisSpacing: 15,
                      //垂直子Widget之间间距
                      mainAxisSpacing: 10,
                      //GridView内边距
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      //一行的Widget数量
                      crossAxisCount: 2,
                      //子Widget宽高比例
                      childAspectRatio: 2.7,
                      //子Widget列表
                      children: _buildEditDrugList(),
                    )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      width: ScreenUtil.screenWidthDp,
                      child: model.empty && model.query.isNotEmpty ? Text('没有找到该药材，请尝试别名或其他制法！',style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                      : ListView.builder(
                        scrollDirection:Axis.horizontal,
                        itemCount: model.list.length,
                        itemBuilder: (context, index) => _buildSearchDrugItem(model,index)
                      ),
                      height: _isShow ? 60 : 0,
                    )
                  )
                ],
              );
            },
          )
      );
    }));
  }

  List<Widget> _buildEditDrugList() {
    List<Widget> widgets = List.generate(drugs.length, (index) {
      return _buildEditDrugItem(_nameControllers[index],
          _countControllers[index],_countFocusNode,index, drugs[index]);
    }).toList();
    widgets.add(_buildEditDrugItem(
      _newNameController, _newCountController, null,drugs.length, null));
    return widgets;
  }

  Widget _buildEditDrugItem(TextEditingController nameController,
      TextEditingController countController, FocusNode countFocusNode,int index, Drug drug) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Consumer<SearchDrugsModel>(builder: (context,model,child){
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: ScreenUtil().setWidth(35),
                      child: drug == null ? TextField(
                        controller: nameController,
                        focusNode: _nameFocusNode,
                        keyboardType: CustomLetterKeyboard.inputType,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                          border: InputBorder.none,
                          hintText: '请输入药材简拼',
                          hintStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: Colors.grey[300],
                          )),
                        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                        onChanged: (text) {
                          model.queryDrug(text);
                        },
                      ):Text(drug.name,style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                    )
                  ),
                  Offstage(
                    offstage: drug == null,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setWidth(35),
                          child: TextField(
                            maxLength: 6,
                            textAlign: TextAlign.right,
                            controller: countController,
                            focusNode: index == drugs.length-1 ? countFocusNode : null,
                            keyboardType: CustomEditDrugBoard.inputType,
                            decoration: InputDecoration(
                              counterText:'',
                              contentPadding: EdgeInsets.only(bottom: ScreenUtil().setWidth(14)),
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(13),
                                color: Theme.of(context).primaryColor,
                              )),
                            style: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            onChanged: (text) {
                              if(text.endsWith('.')){
                                return;
                              }
                              if (text.isEmpty) {
                                showToast('数量最小为1');
                              }
                              if (double.parse(text) > 300) {
                                showToast('数量最大为300');
                                countController.value = TextEditingValue(
                                  // 设置内容
                                  text: '300',
                                  // 保持光标在最后
                                  selection: TextSelection.fromPosition(
                                    TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: '300'.length)));
                              }
                              setState(() {
                                drugs[index].count =
                                  double.parse(countController.text);
                              });
                            },
                            onSubmitted: (text) {
                              Future.delayed(Duration(milliseconds: 200),(){
                                FocusScope.of(context).requestFocus(_nameFocusNode);
                              });
                              model.clearQuery();
                            },
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(3)),
                        Text('克',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(13)))
                      ],
                    )
                  )
                ],
              ),
              Offstage(
                offstage: drug == null,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('煎法',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(13)))),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          drugs.removeAt(index);
                          refreshDrugs();
                        });
                      },
                      child: Image.asset(ImageHelper.wrapAssets('ic_guanbi.png'),
                        width: ScreenUtil().setWidth(18),
                        height: ScreenUtil().setWidth(18)),
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
                          color: Color(0xff798fb7),
                          fontSize: ScreenUtil().setSp(14))),
                    )
                  ],
                ),
              )
            ],
          );
        })
    );
  }

  void refreshDrugs() {
    _countControllers.clear();
    _nameControllers.clear();
    drugs.forEach((drug) {
      TextEditingController c1 = TextEditingController(
          text: drug == null || drug.count == 0
              ? ''
              : '${drug.unitCount == null ? drug.count : drug.unitCount}');
      _countControllers.add(c1);
      TextEditingController c2 =
          TextEditingController(text: drug == null ? '' : '${drug.name}');
      _nameControllers.add(c2);
    });
  }

  Widget _buildSearchDrugItem(SearchDrugsModel model,int index) {
    SimpleDrug drug = model.list[index];
    return GestureDetector(
      onTap: (){
        if(drugs.where((d)=>d.name == drug.name).isNotEmpty){
          showToast('您已添加过此药');
        }else{
          drugs.add(Drug(drug.name, 0,price: drug.price));
          refreshDrugs();
          _newNameController.text='';
          model.clearQuery();
          Future.delayed(Duration(milliseconds: 200),(){
            FocusScope.of(context).requestFocus(_countFocusNode);
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(drug.name,style: TextStyle(fontSize: ScreenUtil().setSp(16),color: Colors.black)),
            Text('${drug.price}元/克',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey))
          ],
        ),
      ),
    );
  }
}

class EditDrugAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Drug> drugs;
  final VoidCallback onClear;

  EditDrugAppBar({this.drugs, this.onClear});

  @override
  State<StatefulWidget> createState() => _EditDrugAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(50));
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
                    Positioned(
                        child: Container(
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
                              if (widget.drugs.isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogAlert(
                                        content: '是否保存当前处方？',
                                        onPressed: () {
                                          Navigator.maybePop(context);
                                          Navigator.of(context)
                                              .pop(widget.drugs);
                                        },
                                        onCancelPressed: () {
                                          Navigator.maybePop(context);
                                        },
                                      );
                                    });
                              } else {
                                Navigator.maybePop(context);
                              }
                            },
                          ),
                        ),
                        left: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(child: SizedBox()),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) =>
                                              ChangeNotifierProvider<
                                                      CategoryModel>.value(
                                                  value: model,
                                                  child: DialogDrugCategory(
                                                      price: getSinglePrice(
                                                          widget.drugs))));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                            '${model.list[model.selectedCategory].child[model.selectedDrugStore].name}-${model.list[model.selectedCategory].name}',
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(16),
                                                color: Colors.black)),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: Colors.black54),
                                      ],
                                    ))),
                            Expanded(
                                child: Row(
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
                                            Navigator.pop(context);
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
                                SizedBox(width: ScreenUtil().setWidth(15)),
                                Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(15)),
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pop(widget.drugs),
                                      child: Center(
                                        child: Text(
                                          '完成',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    )),
                              ],
                            ))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(height: ScreenUtil().setWidth(5)),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  RouteName.singleDrugPriceDetail,
                                  arguments: widget.drugs),
                              child: Text(
                                  '共 ${widget.drugs.length} 味，每剂 ${(widget.drugs.fold(0, (pre, e) => (pre + e.price * e.count))).toStringAsFixed(4)} 元，重 ${widget.drugs.fold(0, (pre, e) => pre + e.count)}克，详情',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                      color: Color(0xffeaaf4c))),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )));
      },
    );
  }

  double getSinglePrice(List<Drug> drugs) {
    return drugs.fold(0, (pre, e) => (pre + e.price * e.count));
  }
}
