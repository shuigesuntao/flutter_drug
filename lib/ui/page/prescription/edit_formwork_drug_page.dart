import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:oktoast/oktoast.dart';

class EditFormWorkDrugPage extends StatefulWidget {

  final List<Drug> drugs;

  EditFormWorkDrugPage({this.drugs});

  @override
  State<StatefulWidget> createState() => _EditFormWorkDrugPageState();
}

class _EditFormWorkDrugPageState extends State<EditFormWorkDrugPage> {
  List<TextEditingController> _controllers = List();

  @override
  void initState() {
    super.initState();
    refreshDrugs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '编辑药材',actions: [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: ()=> showDialog(
              context: context,
              builder: (context) {
                return DialogAlert(
                  title: '提示',
                  content: '是否清空所有已编辑药材',
                  onPressed: () {
                    setState(()=>widget.drugs.clear());
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
          )
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: (){
              if(widget.drugs.isEmpty){
                showToast('请添加药材');
              }else{
                Navigator.of(context).pop(widget.drugs);
              }
            },
            child: Center(
              child: Text(
                '完成',
                style: TextStyle(
                  color: Theme.of(context).primaryColor),
              ),
            ),
          )
        ),
      ]),
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
    List<Widget> widgets = widget.drugs.asMap().keys.map((index) {
      return _buildEditDrugItem(_controllers[index],index, widget.drugs[index]);
    }).toList();
    widgets.add(_buildEditDrugItem(TextEditingController(), widget.drugs.length,null));
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
                          color: drug == null ? Colors.grey[400] : null))),
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
                            widget.drugs[index].count = double.parse(controller.text);
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
                      widget.drugs.remove(drug);
                    });
                  },
                  child: Image.asset(ImageHelper.wrapAssets('ic_guanbi.png'),
                      width: 18, height: 18),
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
    widget.drugs.forEach((drug){
      TextEditingController c = TextEditingController(text: drug == null
        ? ''
        : '${drug.unitCount == null ? drug.count : drug.unitCount}');
      _controllers.add(c);
    });
  }
}