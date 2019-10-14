import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:oktoast/oktoast.dart';

import 'p_take_page.dart';

class PrescriptionOpenPage extends StatefulWidget {
  final Friend friend;
  final bool isWeChat;

  PrescriptionOpenPage({this.friend, this.isWeChat = false});

  @override
  State<StatefulWidget> createState() => PrescriptionOpenPageState();

}

class PrescriptionOpenPageState extends State<PrescriptionOpenPage> {
  int showChecked = 0;
  int wayChecked = 0;
  double singlePrice = 0;
  double category = 1;
  String _gender = '';
  String _countOfBag = '200';
  Friend _friend;

  final TextEditingController _controller = TextEditingController(text:"7");
  final TextEditingController _bagController = TextEditingController(text:"2");
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _chiefComplaintController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _friend = widget.friend;
    _gender = _friend?.gender??'';
    _nameController.value = TextEditingValue(
      // 设置内容
      text: _friend?.displayName??'',
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: (_friend?.displayName??'').length)));

    _phoneController.value = TextEditingValue(
      // 设置内容
      text: _friend?.phone??'',
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: (_friend?.phone??'').length)));

    _ageController.value = TextEditingValue(
      // 设置内容
      text: _friend?.age==null?'':_friend.age.toString(),
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: (_friend?.age==null?'':_friend.age.toString()).length)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TitleBar.buildCommonAppBar(context, '在线开方',onPressed: (){
        showDialog(
          barrierDismissible:false,
          context: context,
          builder: (context) {
            return DialogAlert(
              content: '是否保存为临时处方？',
              onPressed: () {
                print('保存临时处方');
                Navigator.maybePop(context);
                Navigator.maybePop(context);
              },
              onCancelPressed: ()=> Navigator.maybePop(context),
            );
          });
      }),
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(child: Container(width: 3, height: 3, color: Colors.black),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('诊断', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                        ),
                        ClipOval(child: Container(width: 3, height: 3, color: Colors.black),)
                      ],
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: InputBorder.none,
                                hintText: '请选择患者或输入患者手机号',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                              controller: _phoneController,
                              maxLines: 1,
                              textInputAction: TextInputAction.newline,
                              style: TextStyle(fontSize: 14),
                            )
                          ),
                          GestureDetector(
                            child:  Container(
                              width: 85,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                border: Border.all(color: Theme.of(context).primaryColor, width: 1)
                              ),
                              child: Center(child: Text(
                                '选择患者',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),)
                            ),
                            onTap: ()=> Navigator.push(context,CupertinoPageRoute(
                              builder: (context) =>
                                AddressBookPage(
                                  onItemClick: (friend){
                                    setState(() {
                                      _friend = friend;
                                      _nameController.text = friend.displayName;
                                      _phoneController.text = friend.phone;
                                      _ageController.text = friend.age.toString();
                                      _gender = friend.gender;
                                    });
                                  },
                                ),
                            ))
                          )
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  border: InputBorder.none,
                                  hintText: '请输入患者姓名',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                                controller: _nameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.newline,
                                style: TextStyle(fontSize: 14),
                              ),
                              Divider(height: 1,color: Colors.grey[300]),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: ()=>showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  message: Text('请选择'),
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () => Navigator.maybePop(context),
                                    child: Text('取消')),
                                  actions: _buildGenderActions(),
                                )),
                              child: Row(
                                children: <Widget>[
                                  Text(_gender.isEmpty?'性别':_gender),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                          )
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter.digitsOnly
                                      ],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                                        border: InputBorder.none,
                                        hintText: '年龄',
                                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                                      controller: _ageController,
                                      maxLines: 1,
                                      textInputAction: TextInputAction.newline,
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ),
                                  Text('岁')
                                ],
                              ),
                              Divider(height: 1,color: Colors.grey),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: '填写中医病症名称（必填）',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                        controller: _diseaseController,
                        maxLines: 1,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: '请输入主诉、辩证（选填）',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                        controller: _chiefComplaintController,
                        maxLines: 1,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                  ],
                ),
              ),
              SizedBox(height: 15),
              //开方
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ProviderWidget<CategoryModel>(
                  model: CategoryModel(),
                  onModelReady: (model) => model.initData(),
                  builder: (context,model,child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: SizedBox.shrink()),
                            Row(
                              children: <Widget>[
                                ClipOval(child: Container(width: 3, height: 3, color: Colors.black)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('开方', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                                ),
                                ClipOval(child: Container(width: 3, height: 3, color: Colors.black))
                              ],
                            ),
                            Expanded(child:Container(alignment: Alignment.centerRight,child: Text('存为常用方',style: TextStyle(color: Colors.orangeAccent)),))
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child:  model.busy? SizedBox.shrink():DrugStoreItem(
                            price: singlePrice,showPrice: true,
                          )
                        ),
                        Divider(height: 1,color: Colors.grey[300]),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              child:  Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(3)),
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 1)
                                ),
                                child: Center(child: Text(
                                  '+ 编辑药材',
                                  style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16),
                                ),)
                              ),
                              onTap: ()=> print('编辑药材')
                            ),
                            Text('共0味药，总重0g',style: TextStyle(color: Colors.grey))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('R:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500))
                        ),
                        Wrap(
                          spacing: 20,
                          children: _buildDrugWidgets(),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Text('共',style: TextStyle(color: Colors.grey)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.grey[200]),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                controller: _controller,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.number,
                                onChanged: (text){
                                  if(text.isEmpty || int.parse(text) < 1){
                                    showToast('处方剂量最小为1剂');
                                    _controller.text = '';
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(5)
                                ),
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Text('剂',style: TextStyle(color: Colors.grey)),
                            Expanded(
                              child: Offstage(
                                offstage: model.selectedCategory != 1,
                                child: Row(
                                  children: <Widget>[
                                    Text('，每剂',style: TextStyle(color: Colors.grey)),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      width: 40,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Colors.grey[200]),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white
                                      ),
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter.digitsOnly
                                        ],
                                        controller: _bagController,
                                        textInputAction: TextInputAction.newline,
                                        keyboardType: TextInputType.number,
                                        onChanged: (text){
                                          if(text.isEmpty || int.parse(text) < 1){
                                            showToast('每剂袋数最小为1袋');
                                            _bagController.text = '';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(5)
                                        ),
                                        style: TextStyle(color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    Text('袋，每袋',style: TextStyle(color: Colors.grey)),
                                    GestureDetector(
                                      onTap: ()=>showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => CupertinoActionSheet(
                                          message: Text('请选择'),
                                          cancelButton: CupertinoActionSheetAction(
                                            onPressed: () => Navigator.maybePop(context),
                                            child: Text('取消')),
                                          actions: _buildCountOfBagActions(),
                                        )),
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Colors.grey[200]),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white
                                        ),
                                        child: Text(
                                          _countOfBag,
                                          style: TextStyle(color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    ),
                                    Text('ml',style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                ),
              ),
              SizedBox(height: 15),
              //医嘱
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(child: Container(width: 3, height: 3, color: Colors.black),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('医嘱', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                        ),
                        ClipOval(child: Container(width: 3, height: 3, color: Colors.black),)
                      ],
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('用药方法')),
                          Row(
                            children: <Widget>[
                              _buildWayButton(0,'内服'),
                              SizedBox(width: 10),
                              _buildWayButton(1,'外用')
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('用药医嘱')),
                          Text('选填',style: TextStyle(color: Colors.grey)),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('补充医嘱')),
                          Text('选填',style: TextStyle(color: Colors.grey)),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                  ],
                ),
              ),
              SizedBox(height: 15),
              //复诊随访时间
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('复诊及随访时间')),
                      Row(
                        children: <Widget>[
                          Text('系统默认'),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              //划价
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(child: Container(width: 3, height: 3, color: Colors.black),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('划价', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                        ),
                        ClipOval(child: Container(width: 3, height: 3, color: Colors.black),)
                      ],
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:  Row(
                        children: <Widget>[
                          Expanded(child: Text('设置诊费')),
                          Text('免费'),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('单次处方服务费')),
                          Text('￥0'),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('处方合计：0.00元',style: TextStyle(fontWeight: FontWeight.w300))),
                          Text('明细'),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1,color: Colors.grey[300]),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('处方是否可见处方')),
                    Row(
                      children: <Widget>[
                        _buildShowButton(0,'可见'),
                        SizedBox(width: 10),
                        _buildShowButton(1,'不可见')
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => print('确认签名并发送'),
                    color: Theme
                      .of(context)
                      .primaryColor,
                    child: Text(
                      '确认签名并发送',
                      style: TextStyle(fontSize:18,color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                bottom: true
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGenderActions() {
    final List<String> genders = [
      '男',
      '女',
    ];
    return genders
      .map((gender) => CupertinoActionSheetAction(
      onPressed: () {
        setState(() {
          _gender = gender;
        });
        Navigator.maybePop(context);
      },
      child: Text(gender)))
      .toList();
  }


  List<Widget> _buildCountOfBagActions() {
    final List<String> levels = [
      '50',
      '100',
      '150',
      '200',
      '250'
    ];
    return levels
      .map((countOfBag) => CupertinoActionSheetAction(
      onPressed: () {
        setState(() {
          _countOfBag = countOfBag;
        });
        Navigator.maybePop(context);
      },
      child: Text(countOfBag)))
      .toList();
  }

  List<Widget> _buildDrugWidgets(){
    List<Drug> drugs = [Drug('党参',12),Drug('麸炒白术',9),Drug('茯苓',9),Drug('炙甘草',5),Drug('陈皮',3),Drug('法半夏',3),Drug('生姜',3),Drug('大枣',1,unit: '枚(约10克)'),Drug('当归',9),Drug('白芍',9)];
    return drugs.map((drug)=> Padding(padding: EdgeInsets.symmetric(vertical: 8),child: Text('${drug.name}${drug.count}${drug.unit}',style: TextStyle(fontSize: 15),))).toList();
  }

  Widget _buildShowButton(int index,String text){
    return GestureDetector(
      onTap: ()=>setState(()=>showChecked = index),
      child: SizedBox(
        width: 55,
        height: 25,
        child: Container(
          alignment: Alignment.center,
          child: Text(text,style:TextStyle(color: showChecked == index ? Colors.white : Colors.grey[400])),
          decoration: BoxDecoration(
            border: showChecked == index ? null : Border.all(color: Colors.grey[400], width: 1),
            borderRadius:BorderRadius.all(Radius.circular(3)),
            color: showChecked == index ? Theme.of(context).primaryColor : Colors.white
          ),
        ),
      ),
    );
  }

  Widget _buildWayButton(int index,String text){
    return GestureDetector(
      onTap: ()=>setState(()=>wayChecked = index),
      child: SizedBox(
        width: 55,
        height: 23,
        child: Container(
          alignment: Alignment.center,
          child: Text(text,style:TextStyle(color: wayChecked == index ? Colors.white : Colors.grey[400])),
          decoration: BoxDecoration(
            border: wayChecked == index ? null : Border.all(color: Colors.grey[400], width: 1),
            borderRadius:BorderRadius.all(Radius.circular(3)),
            color: wayChecked == index ? Theme.of(context).primaryColor : Colors.white
          ),
        ),
      ),
    );
  }
}
