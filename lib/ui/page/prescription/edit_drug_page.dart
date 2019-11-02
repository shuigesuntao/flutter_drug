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

class EditDrugPage extends StatefulWidget{

  final List<Drug> drugs;
  final int category;
  final int drugStore;

  EditDrugPage({this.drugs,this.category,this.drugStore});

  @override
  State<StatefulWidget> createState()=>_EditDrugPageState(drugs);
}

class _EditDrugPageState extends State<EditDrugPage>{
  List<Drug> drugs;
  List<TextEditingController> _controllers = List();

  _EditDrugPageState(this.drugs);

  @override
  Widget build(BuildContext context) {
    return  Consumer<CategoryModel>(
      builder: (context,model,child){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Builder(builder: (context){
              return GestureDetector(
                onTap: (){
                  showBottomSheet(
                    backgroundColor:Colors.transparent,
                    context: context,
                    builder: (context) => ChangeNotifierProvider<CategoryModel>.value(value: model,child: DialogDrugCategory(price:getSinglePrice(drugs)))
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${model.list[model.selectedCategory].child[model.selectedDrugStore].name}-${model.list[model.selectedCategory].name}',style: TextStyle(fontSize: 16,color: Colors.white)),
                    Icon(Icons.keyboard_arrow_down,color: Colors.white,)
                  ],
                ),
              );
            }),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 44,
                  padding: EdgeInsets.all(0),
                  child: new IconButton(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    icon: Image.asset(
                      ImageHelper.wrapAssets('ic_back_black.png'),
                      fit: BoxFit.contain,
                      color: Colors.white,
                      width: 16,
                      height: 16,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.maybePop(context);
                    },
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: ()=> Navigator.of(context).pop(drugs),
                  child: Center(
                    child: Text(
                      '完成',
                      style: TextStyle(fontSize:16,color:Colors.white),
                    ),
                  ),
                ))
            ],
          ),
          body: GestureDetector(
            onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10,5,10,5),
                  color: Colors.yellow[200],
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('共 ${drugs.length} 味药材，每剂重 ${drugs.fold(0, (pre,e)=>pre+(e.unitCount==null?e.count:e.unitCount))} 克，每剂 ${drugs.fold(0, (pre, e) => (pre + e.price * e.count))} 元',style: TextStyle(fontSize: 12))),
                      GestureDetector(
                        onTap: ()=> Navigator.of(context).pushNamed(RouteName.singleDrugPriceDetail,arguments: drugs),
                        child: Row(
                          children: <Widget>[
                            Text('详情',style: TextStyle(fontSize: 12)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
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
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildEditDrugList(){
    List<Widget> widgets = drugs.map((Drug drug) {
      TextEditingController controller = TextEditingController();
      _controllers.add(controller);
      return _buildEditDrugItem(controller, drug);
    }).toList();
    widgets.add(_buildEditDrugItem(TextEditingController(),null));
    return widgets;
  }

  double getSinglePrice(List<Drug> drugs){
    return drugs.fold(0, (pre, e) => (pre + e.price * e.count));
  }

  Widget _buildEditDrugItem(TextEditingController controller, Drug drug) {
    controller.value = TextEditingValue(
      // 设置内容
      text: drug == null?'':'${drug.unitCount==null?drug.count:drug.unitCount}',
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: (drug == null?0:'${drug.unitCount==null?drug.count:drug.unitCount}'.length))));
    return Container(
      padding: EdgeInsets.fromLTRB(10,5,10,5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(drug == null?'请输入药材简拼':drug.name,style: TextStyle(color: drug == null?Colors.grey[300]:null))),
              Offstage(
                offstage: drug == null,
                child:Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter
                            .digitsOnly
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: '0',
                          hintStyle: TextStyle(fontSize: 14, color: Color(0xFFcccccc),)
                        ),
                        style: TextStyle(fontSize: 12),
                        onChanged: (text) {
                          if (int.parse(text) > 300) {
                            showToast('数量最大为300');
                            controller.text = '300';
                          }
                        },
                      ),
                    ),
                    Text('克')
                  ],
                )
              )
            ],
          ),
          SizedBox(height: 5),
          Offstage(
            offstage: drug ==null,
            child: Row(
              children: <Widget>[
                Expanded(child: Text('入煎方法',style: TextStyle(color: Colors.grey[300],fontSize: 13))),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      drugs.remove(drug);
                    });
                  },
                  child: Image.asset(ImageHelper.wrapAssets('ic_guanbi.png'),width: 15,height: 15),
                )
              ],
            ),
          ),
          Offstage(
            offstage: drug != null,
            child: Row(
              children: <Widget>[
                Expanded(child: GestureDetector(
                  onTap: (){
                    showDialog(context: context,
                      builder: (context) {
                        return DialogAlert(
                          title: '提示',
                          content: '是否清空所有已编辑药材',
                          onPressed: () {
                            setState(() {
                              drugs.clear();
                            });
                            Navigator.maybePop(context);
                          },
                        );
                      });
                  },
                  child: Text('清空',style: TextStyle(color: Colors.red,fontSize: 13)),
                )),
                GestureDetector(
                  onTap: ()=>Navigator.of(context).pushNamed(RouteName.prescriptionFormWork,arguments: true).then((data){
                    if(data != null){
                      setState(() {
                        drugs = data;
                      });
                    }
                  }),
                  child: Text('处方模板',style: TextStyle(color: Colors.blueAccent[400],fontSize: 13)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}