import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/widget/diaglog_open_p_tip.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/drug_store_item.dart';
import 'package:flutter_drug/ui/widget/dialog_yizhu_select.dart';
import 'package:flutter_drug/ui/widget/dialog_zhenfei.dart';
import 'package:flutter_drug/ui/widget/picker.dart';
import 'package:flutter_drug/ui/widget/dialog_gaofangfuliao_select.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'edit_drug_page.dart';

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
  double category = 1;
  String _gender = '';
  String _countOfBag = '200';
  Friend _friend;
  String _gaoAssist = '';
  String _yizhuTime = '';
  String _yizhuJiKou = '';
  String _yizhuBuChong = '';
  List<Drug> _drugs = [];
  bool isShowPriceDetail = false;
  bool isDefaultPercent = true;
  double _drugPrice = 0;
  int _zhenfei = 0;
  int _jiagongfei = 0;
  int _currentPercent;
  int _defaultPercent = 10;
  bool _isHide = false;

  final TextEditingController _controller = TextEditingController(text: "7");
  final TextEditingController _bagController = TextEditingController(text: "2");
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _chiefComplaintController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentPercent = _defaultPercent;
    _friend = widget.friend;
    _gender = _friend?.gender ?? '';
    _nameController.value = TextEditingValue(
      // 设置内容
      text: _friend?.displayName ?? '',
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: (_friend?.displayName ?? '').length)));

    _phoneController.value = TextEditingValue(
      // 设置内容
      text: _friend?.phone ?? '',
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: (_friend?.phone ?? '').length)));

    _ageController.value = TextEditingValue(
      // 设置内容
      text: _friend?.age == null ? '' : _friend.age.toString(),
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset:
        (_friend?.age == null ? '' : _friend.age.toString()).length)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TitleBar.buildCommonAppBar(context, '在线开方', onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return DialogAlert(
              content: '是否保存为临时处方？',
              onPressed: () {
                print('保存临时处方');
                Navigator.maybePop(context);
                Navigator.maybePop(context);
              },
              onCancelPressed: () => Navigator.maybePop(context),
            );
          });
      }),
      body: Builder(builder: (context){
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                // 诊断
                _buildZhenduanWidget(),
                SizedBox(height: 15),
                // 开方
                _buildKaifangWidget(),
                SizedBox(height: 15),
                // 医嘱
                _buildYizhuWidget(context),
                SizedBox(height: 15),
                // 复诊随访时间
                GestureDetector(
                  onTap: () {},
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
                // 划价
                _buildHuajiaWidget(context),
                SizedBox(height: 15),
                // 处方是否可见
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
                          _buildShowButton(0, '可见'),
                          SizedBox(width: 10),
                          _buildShowButton(1, '不可见')
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // 提交
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
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  bottom: true),
              ],
            ),
          ),
        );
      }),
    );
  }
  /// 诊断
  Widget _buildZhenduanWidget() {
    return Container(
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
              ClipOval(
                child: Container(
                  width: 3, height: 3, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('诊断',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18))),
              ClipOval(
                child: Container(
                  width: 3, height: 3, color: Colors.black),
              )
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
                      hintStyle: TextStyle(
                        color: Colors.grey, fontSize: 14)),
                    controller: _phoneController,
                    maxLines: 1,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(fontSize: 14),
                  )),
                GestureDetector(
                  child: Container(
                    width: 85,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                        color: Theme
                          .of(context)
                          .primaryColor,
                        width: 1)),
                    child: Center(
                      child: Text(
                        '选择患者',
                        style: TextStyle(
                          color:
                          Theme
                            .of(context)
                            .primaryColor),
                      ),
                    )),
                  onTap: () =>
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                          AddressBookPage(
                            onItemClick: (friend) {
                              setState(() {
                                _friend = friend;
                                _nameController.text =
                                  friend.displayName;
                                _phoneController.text = friend.phone;
                                _ageController.text =
                                  friend.age.toString();
                                _gender = friend.gender;
                              });
                            },
                          ),
                      )))
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10),
                        border: InputBorder.none,
                        hintText: '请输入患者姓名',
                        hintStyle: TextStyle(
                          color: Colors.grey, fontSize: 14)),
                      controller: _nameController,
                      maxLines: 1,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: 14),
                    ),
                    Divider(height: 1, color: Colors.grey[300]),
                  ],
                )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () =>
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                        CupertinoActionSheet(
                          message: Text('请选择'),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () =>
                              Navigator.maybePop(context),
                            child: Text('取消')),
                          actions: _buildGenderActions(),
                        )),
                  child: Row(
                    children: <Widget>[
                      Text(_gender.isEmpty ? '性别' : _gender),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter
                                .digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 10),
                              border: InputBorder.none,
                              hintText: '年龄',
                              hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 14)),
                            controller: _ageController,
                            maxLines: 1,
                            textInputAction: TextInputAction.newline,
                            style: TextStyle(fontSize: 14),
                          )),
                        Text('岁')
                      ],
                    ),
                    Divider(height: 1, color: Colors.grey),
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
                hintStyle:
                TextStyle(color: Colors.grey, fontSize: 14)),
              controller: _diseaseController,
              maxLines: 1,
              textInputAction: TextInputAction.newline,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                hintText: '请输入主诉、辩证（选填）',
                hintStyle:
                TextStyle(color: Colors.grey, fontSize: 14)),
              controller: _chiefComplaintController,
              maxLines: 1,
              textInputAction: TextInputAction.newline,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }

  /// 选择性别
  List<Widget> _buildGenderActions() {
    final List<String> genders = [
      '男',
      '女',
    ];
    return genders
      .map((gender) =>
      CupertinoActionSheetAction(
        onPressed: () {
          setState(() {
            _gender = gender;
          });
          Navigator.maybePop(context);
        },
        child: Text(gender)))
      .toList();
  }

  /// 开方
  Widget _buildKaifangWidget() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: ProviderWidget<CategoryModel>(
        model: CategoryModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: SizedBox.shrink()),
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          width: 3,
                          height: 3,
                          color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('开方',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
                      ClipOval(
                        child: Container(
                          width: 3, height: 3, color: Colors.black))
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text('存为常用方',
                        style: TextStyle(color: Colors.orangeAccent)),
                    ))
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: model.busy
                  ? SizedBox.shrink()
                  : DrugStoreItem(drugs: _drugs)
              ),
              Divider(height: 1, color: Colors.grey[300]),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(3)),
                        border: Border.all(
                          color: Theme
                            .of(context)
                            .primaryColor,
                          width: 1)),
                      child: Center(
                        child: Text(
                          '+ 编辑药材',
                          style: TextStyle(
                            color: Theme
                              .of(context)
                              .primaryColor,
                            fontSize: 16),
                        ),
                      )),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context)=>ChangeNotifierProvider<CategoryModel>.value(value: model,child: EditDrugPage(drugs: _drugs)))
                      ).then((data){
                        if(data != null){
                          setState(() {
                            _drugs = data;
                          });
                        }
                      });
                    }
                  ),
                  Text('共${_drugs.length}味药，总重${_drugs.fold(0, (pre,e)=>pre+(e.unitCount==null?e.count:e.unitCount))}g',
                    style: TextStyle(color: Colors.grey))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('R:',
                  style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w500))),
              _drugs.isEmpty ? SizedBox.shrink() : Wrap(
                spacing: 20,
                children: _buildDrugWidgets(),
              ),
              SizedBox(height: 10),
              _buildCountWidget(model.selectedCategory)
            ],
          ),
      ),
    );
  }

  /// 毫升数
  List<Widget> _buildCountOfBagActions() {
    final List<String> levels = ['50', '100', '150', '200', '250'];
    return levels
      .map((countOfBag) =>
      CupertinoActionSheetAction(
        onPressed: () {
          setState(() {
            _countOfBag = countOfBag;
          });
          Navigator.maybePop(context);
        },
        child: Text(countOfBag)))
      .toList();
  }


  /// 药品列表
  List<Widget> _buildDrugWidgets() {
    return _drugs
      .map((drug) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          '${drug.name}${drug.count}${drug.unit}',
          style: TextStyle(fontSize: 15),
        )))
      .toList();
  }

  /// 根据类型显示不同数量
  Widget _buildCountWidget(int category) {
    Widget widget = SizedBox.shrink();
    switch (category) {
      case 0:
      case 5:
      case 6:
      case 7:
        widget = Row(
          children: <Widget>[
            Text('共', style: TextStyle(color: Colors.grey)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
              child: TextField(
                textAlign: TextAlign.center,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _controller,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty || int.parse(text) < 1) {
                    showToast('处方剂量最小为1剂');
                    _controller.text = '';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5)),
                style: TextStyle(
                  color: Theme
                    .of(context)
                    .primaryColor),
              ),
            ),
            Text('剂', style: TextStyle(color: Colors.grey)),
          ],
        );
        break;
      case 1:
        widget = Row(
          children: <Widget>[
            Text('共', style: TextStyle(color: Colors.grey)),
            Expanded(
              child: Container(
                margin:
                EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1, color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
                child: TextField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    WhitelistingTextInputFormatter
                      .digitsOnly
                  ],
                  controller: _controller,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    if (text.isEmpty ||
                      int.parse(text) < 1) {
                      showToast('处方剂量最小为1剂');
                      _controller.text = '';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5)),
                  style: TextStyle(
                    color:
                    Theme
                      .of(context)
                      .primaryColor),
                ),
              ),
            ),
            Text('剂', style: TextStyle(color: Colors.grey)),
            Text('，每剂',
              style: TextStyle(color: Colors.grey)),
            Expanded(
              child: Container(
                margin:
                EdgeInsets.symmetric(horizontal: 10),
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1, color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
                child: TextField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    WhitelistingTextInputFormatter
                      .digitsOnly
                  ],
                  controller: _bagController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    if (text.isEmpty ||
                      int.parse(text) < 1) {
                      showToast('每剂袋数最小为1袋');
                      _bagController.text = '';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5)),
                  style: TextStyle(
                    color:
                    Theme
                      .of(context)
                      .primaryColor),
                ),
              ),
            ),
            Text('袋，每袋',
              style: TextStyle(color: Colors.grey)),
            Expanded(
              child: GestureDetector(
                onTap: () =>
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) =>
                      CupertinoActionSheet(
                        message: Text('请选择'),
                        cancelButton:
                        CupertinoActionSheetAction(
                          onPressed: () =>
                            Navigator.maybePop(
                              context),
                          child: Text('取消')),
                        actions:
                        _buildCountOfBagActions(),
                      )),
                child: Container(
                  alignment: Alignment.center,
                  margin:
                  EdgeInsets.symmetric(horizontal: 10),
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[200]),
                    borderRadius:
                    BorderRadius.circular(5),
                    color: Colors.white),
                  child: Text(
                    _countOfBag,
                    style: TextStyle(
                      color:
                      Theme
                        .of(context)
                        .primaryColor),
                  ),
                ),
              ),
            ),
            Text('ml',
              style: TextStyle(color: Colors.grey)),
          ],
        );
        break;
      case 2:
        widget = Row(
          children: <Widget>[
            Text('共', style: TextStyle(color: Colors.grey)),
            Container(
              margin:
              EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
              child: TextField(
                textAlign: TextAlign.center,
                inputFormatters: [
                  WhitelistingTextInputFormatter
                    .digitsOnly
                ],
                controller: _controller,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty ||
                    int.parse(text) < 1) {
                    showToast('处方剂量最小为1剂');
                    _controller.text = '';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5)),
                style: TextStyle(
                  color:
                  Theme
                    .of(context)
                    .primaryColor),
              ),
            ),
            Text('剂', style: TextStyle(color: Colors.grey)),
            Text('，每剂',
              style: TextStyle(color: Colors.grey)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
              child: TextField(
                textAlign: TextAlign.center,
                inputFormatters: [
                  WhitelistingTextInputFormatter
                    .digitsOnly
                ],
                controller: _bagController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty ||
                    int.parse(text) < 1) {
                    showToast('每剂袋数最小为1袋');
                    _bagController.text = '';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5)),
                style: TextStyle(
                  color:
                  Theme
                    .of(context)
                    .primaryColor),
              ),
            ),
            Text('袋', style: TextStyle(color: Colors.grey)),
          ],
        );
        break;
      case 3:
        widget = Row(
          children: <Widget>[
            Text('共', style: TextStyle(color: Colors.grey)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
              child: TextField(
                textAlign: TextAlign.center,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _controller,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty || int.parse(text) < 1) {
                    showToast('处方剂量最小为1剂');
                    _controller.text = '';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5)),
                style: TextStyle(
                  color: Theme
                    .of(context)
                    .primaryColor),
              ),
            ),
            Text('剂，*建议处方重量在1kg以上', style: TextStyle(color: Colors.grey)),
            GestureDetector(
              onTap: () =>
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => TipDialog()
                ),
              child: ImageIcon(
                AssetImage(ImageHelper.wrapAssets('ic_shuoming.png')),
                size: 15,
                color: Colors.grey[400],
              ),
            ),
          ],
        );
        break;
      case 4:
        widget = Row(
          children: <Widget>[
            Text('共', style: TextStyle(color: Colors.grey)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
              child: TextField(
                textAlign: TextAlign.center,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _controller,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty || int.parse(text) < 1) {
                    showToast('处方剂量最小为1剂');
                    _controller.text = '';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5)),
                style: TextStyle(
                  color: Theme
                    .of(context)
                    .primaryColor),
              ),
            ),
            Text('剂，*每丸9克', style: TextStyle(color: Colors.grey)),
          ],
        );
        break;
      case 8:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('共', style: TextStyle(color: Colors.grey)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, color: Colors.grey[200]),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                  child: TextField(
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    controller: _controller,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      if (text.isEmpty || int.parse(text) < 1) {
                        showToast('处方剂量最小为1剂');
                        _controller.text = '';
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(5)),
                    style: TextStyle(
                      color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                ),
                Text('剂', style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () =>
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                    DialogGaoFangFuLiaoSelect(
                      ['蜂蜜', '木糖醇'],
                      selectList: [_gaoAssist],
                      height: 150,
                      onConfirm: (data) {
                        setState(() {
                          _gaoAssist = data;
                        });
                      })
                ),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('膏方辅料选择')),
                  Text(_gaoAssist.isEmpty ? '选择' : _gaoAssist, style: TextStyle(
                    fontSize: 13,
                    color: _gaoAssist.isEmpty ? Colors.grey : null),),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            )
          ],
        );
        break;
    }
    return widget;
  }


  /// 医嘱
  Widget _buildYizhuWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          //标题
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Container(
                  width: 3, height: 3, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('医嘱',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18))),
              ClipOval(
                child: Container(
                  width: 3, height: 3, color: Colors.black),
              )
            ],
          ),
          SizedBox(height: 5),
          //服药方式
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('用药方法')),
                Row(
                  children: <Widget>[
                    _buildWayButton(0, '内服'),
                    SizedBox(width: 10),
                    _buildWayButton(1, '外用')
                  ],
                )
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          //用药医嘱
          GestureDetector(
            onTap: ()=> showBottomSheet(
              backgroundColor:Colors.transparent,
              context: context,
              builder: (context) =>
                DialogYiZhuSelect(
                  ['饭前半小时服','饭后半小时服','空腹服','睡前服','晨起服'],
                  ['备孕禁用','怀孕禁用','经期停用','感冒停用','忌西药通用','辛辣','油腻','生冷','烟酒','发物','荤腥','酸涩','刺激性食物','光敏性食物','难消化食物'],
                  selectTimeList: _yizhuTime.split(',').where((item)=>item.isNotEmpty).toList(),
                  selectJiKouList: _yizhuJiKou.split(',').where((item)=>item.isNotEmpty).toList(),
                  onConfirm: (time,jiKou) {
                    setState(() {
                      _yizhuTime = time;
                      _yizhuJiKou = jiKou;
                    });
                  })
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Text('用药医嘱'),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        _yizhuTime.isEmpty && _yizhuJiKou.isEmpty
                          ?'选填'
                          :_yizhuTime.isEmpty
                            ?_yizhuJiKou
                            :_yizhuJiKou.isEmpty
                              ?_yizhuTime
                              :_yizhuTime + ',' + _yizhuJiKou,
                        maxLines:1,
                        overflow: TextOverflow.ellipsis ,
                        style: TextStyle(color: _yizhuTime.isEmpty && _yizhuJiKou.isEmpty ? Colors.grey : null)),
                    )
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          //补充医嘱
          GestureDetector(
            onTap: ()=> Navigator.of(context).pushNamed(RouteName.prescriptionYiZhu,arguments: _yizhuBuChong).then((result){
              if(result != null){
                setState(() {
                  _yizhuBuChong = result;
                });
              }
            }),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('补充医嘱')),
                  Text(_yizhuBuChong.isEmpty?'选填':_yizhuBuChong, style: TextStyle(color: _yizhuBuChong.isEmpty?Colors.grey:null)),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }

  /// 服用方式按钮
  Widget _buildWayButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => wayChecked = index),
      child: SizedBox(
        width: 55,
        height: 23,
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(
              color:
              wayChecked == index ? Colors.white : Colors.grey[400])),
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

  /// 处方是否可见按钮
  Widget _buildShowButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => showChecked = index),
      child: SizedBox(
        width: 55,
        height: 25,
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(
              color:
              showChecked == index ? Colors.white : Colors.grey[400])),
          decoration: BoxDecoration(
            border: showChecked == index
              ? null
              : Border.all(color: Colors.grey[400], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: showChecked == index
              ? Theme
              .of(context)
              .primaryColor
              : Colors.white),
        ),
      ),
    );
  }

  /// 划价
  Widget _buildHuajiaWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Container(
                  width: 3, height: 3, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('划价',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18))),
              ClipOval(
                child: Container(
                  width: 3, height: 3, color: Colors.black),
              )
            ],
          ),
          SizedBox(height: 5),
          // 设置诊费
          GestureDetector(
            onTap: (){
              showBottomSheet(
                context: context,
                builder: (context){
                  return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,  //边距（必要）
                    duration: const Duration(milliseconds: 100), //时常 （必要）
                    child: ZhenFeiDialog(
                      selected: _zhenfei==0?'免费':_zhenfei.toString(),
                      isHide: _isHide,
                      onConfirm: (data,isHide) {
                        setState(() {
                          _zhenfei = data=='免费'? 0 : int.parse(data);
                          _isHide = isHide;
                        });
                      }),
                  );
                }
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:
                      Row(
                        children: <Widget>[
                          Text('设置诊费'),
                          Offstage(
                            offstage: !_isHide,
                            child: Text('（附加到药费展示）', style: TextStyle(
                              color: Colors.grey[400],fontSize: 13)),
                          ),
                        ]
                      )
                  ),
                  Text('${_zhenfei==0?'免费':'￥$_zhenfei'}'),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          // 单次处方服务费
          GestureDetector(
            onTap: () {
              if (_drugs.isEmpty) {
                showToast('请先编辑处方药材!');
              } else {
                Picker(
                  selecteds: [isDefaultPercent?0:_currentPercent ~/ 5 + 1],
                  title:'单次处方服务费',
                  adapter: PickerDataAdapter<String>(
                    pickerdata: _getSingleServicePriceList(getTotalDrugPrice()),
                  ),
                  itemExtent: 45,
                  selectedTextStyle: TextStyle(color: Colors.black),
                  onConfirm: (Picker picker, List value) {
                    setState(() {
                      isDefaultPercent = value[0] == 0;
                      _currentPercent = isDefaultPercent ? _defaultPercent:(value[0] - 1) * 5;
                    });
                  }
                ).showModal(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('单次处方服务费')),
                  Text(isDefaultPercent ?'系统默认':'￥${_getSingleServicePrice()}'),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          // 处方合计
          GestureDetector(
            onTap: () {
              if (_drugs.isEmpty) {
                showToast('请先编辑处方药材!');
              } else {
                setState(() {
                  isShowPriceDetail = !isShowPriceDetail;
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('处方合计：${(getTotalDrugPrice() + _zhenfei +  _getSingleServicePrice() + _jiagongfei).toStringAsFixed(2)}元',
                      style:
                      TextStyle(fontWeight: FontWeight.bold))),
                  Text(isShowPriceDetail ? '收起' : '明细'),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          // 明细
          Offstage(
            offstage: !isShowPriceDetail,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Padding(padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('药费',
                        style: TextStyle(color: Colors.grey[700])),
                      Text('￥$_drugPrice x ${_controller.text}剂 = ￥${(getTotalDrugPrice()).toStringAsFixed(2)}'),
                    ],
                  )),
                Padding(padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('诊费',
                            style: TextStyle(color: Colors.grey[700])),
                          Offstage(
                            offstage: !_isHide,
                            child: Text('（附加到药费展示）', style: TextStyle(
                              color: Colors.grey[400],fontSize: 13)),
                          )
                        ],
                      ),
                      Text('￥$_zhenfei'),
                    ],
                  )),
                Padding(padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('单次处方服务费', style: TextStyle(
                            color: Colors.grey[700])),
                          Text('（附加到药费展示）', style: TextStyle(
                            color: Colors.grey[400],fontSize: 13)),
                        ],
                      ),
                      Text('￥${_getSingleServicePrice()}'),
                    ],
                  )),
                Padding(padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('处方加工费', style: TextStyle(color: Colors.grey[700])),
                      Text('￥$_jiagongfei'),
                    ],
                  )),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 药品费用
  double getTotalDrugPrice(){
    return _drugPrice * double.parse(_controller.text);
  }

  /// 单次处方服务费
  int _getSingleServicePrice() {
    return getTotalDrugPrice() * _currentPercent ~/ 100;
  }

  /// 单次处方服务费对话框选项
  List<String> _getSingleServicePriceList(double price) {
    List<String> data = List();
    for (int i = 0; i <= 100; i+=5) {
      data.add('￥${price * i ~/ 100}（药费$i%）');
    }
    data.insert(0, '系统默认￥${price * _defaultPercent ~/ 100}（药费$_defaultPercent%）');
    return data;
  }
}



