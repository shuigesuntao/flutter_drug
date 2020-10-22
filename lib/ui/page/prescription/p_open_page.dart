import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/model/illegal_drugs.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/diaglog_open_p_tip.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_fuzhen_time.dart';
import 'package:flutter_drug/ui/widget/drug_store_item.dart';
import 'package:flutter_drug/ui/widget/dialog_yizhu_select.dart';
import 'package:flutter_drug/ui/widget/dialog_zhenfei.dart';
import 'package:flutter_drug/ui/widget/picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart' hide BuildContext;

import 'edit_drug_page.dart';

class PrescriptionOpenPage extends StatefulWidget {
  final Friend friend;
  final bool isWeChat;
  final bool isImage;

  PrescriptionOpenPage(
      {this.friend, this.isWeChat = false, this.isImage = false});

  @override
  State<StatefulWidget> createState() => PrescriptionOpenPageState();
}

class PrescriptionOpenPageState extends State<PrescriptionOpenPage> {
  int showChecked = 0;
  int wayChecked = 0;
  int packWay = 0;
  int tisnaWay = 1;
  int gaoAssist = -1; //0 蜂蜜 1 木糖醇
  double category = 1;
  String _gender = '';
  Friend _friend;
  String _yizhuTime = '';
  String _yizhuJiKou = '';
  String _yizhuBuChong = '';
  String _ml = '200';
  List<Drug> _drugs = [];
  List<Poison> poisons = [];
  List<Conflict> conflicts = [];
  bool isShowPriceDetail = false;
  bool isDefaultPercent = true;
  bool isKeLiCount = false;
  double _drugPrice = 0;
  int _zhenfei = 0;
  int _jiagongfei = 0;
  int _fuzhenTime = 7;
  int _suifangTime = 4;
  String _fuzhenText = '系统默认';
  int _currentPercent;
  int _defaultPercent = 10;
  String originImage =
      'https://app.zgzydb.com/upload/Prescription/191009202635453169f79cae0e245bebcb482c280b66c95.jpg';
  bool _isHide = false;
  bool _isConfirm = false;

  String _countOfDay = '';//每日服药次数
  String _countOfUse = '';//每次服药数量
  String _countOfBag = '';//袋数

  final TextEditingController _controller = TextEditingController(text: "7");//剂量
  final TextEditingController _bagController = TextEditingController();//袋数
  final TextEditingController _countOfDayController = TextEditingController();//每日服药次数
  final TextEditingController _countOfUseDrugController = TextEditingController();//每次服药数量

  final TextEditingController _nameController = TextEditingController(); //姓名
  final TextEditingController _phoneController = TextEditingController(); //电话
  final TextEditingController _ageController = TextEditingController(); //年龄
  final TextEditingController _diseaseController = TextEditingController(); //病症
  final TextEditingController _chiefComplaintController = TextEditingController(); //辩证

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
      appBar: TitleBar.buildCommonAppBar(
          context, widget.isImage ? '拍方上传' : '在线开方',
          actionText: widget.isImage ? '查看原图片' : null, onActionPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PhotoView(
              onTapDown: (context, details, controllerValue) {
                Navigator.of(context).pop();
              },
              imageProvider: NetworkImage(originImage),
            ),
          ),
        );
      }, onPressed: () {
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
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              child: Column(
                children: <Widget>[
                  // 诊断
                  _buildZhenduanWidget(),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  // 开方
                  _buildKaifangWidget(),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  // 超量与配伍禁忌
                  Offstage(
                    offstage: poisons.length == 0 && conflicts.length == 0,
                    child: Padding(
                      padding:
                      EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
                      child: _buildExcessWidget(context)),
                  ),
                  // 医嘱
                  _buildYizhuWidget(context),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  // 复诊随访时间
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => DialogFuzhenTime(
                        fuzhenTime: _fuzhenTime,
                        suifangTime: _suifangTime,
                        onConfirm: (fuzhenTime, suifangTime) {
                          setState(() {
                            _fuzhenText = '已设置';
                            _fuzhenTime = fuzhenTime;
                            _suifangTime = suifangTime;
                          });
                        })),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15)),
                      height: ScreenUtil().setWidth(50),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('复诊及随访时间',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14)))),
                          Row(
                            children: <Widget>[
                              Text(_fuzhenText,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14))),
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
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  // 划价
                  _buildHuajiaWidget(context),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  // 处方是否可见
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    height: ScreenUtil().setWidth(50),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('处方是否可见处方',
                            style:
                            TextStyle(fontSize: ScreenUtil().setSp(14)))),
                        Row(
                          children: <Widget>[
                            _buildShowButton(0, '可见'),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            _buildShowButton(1, '不可见')
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  // 提交
                  SafeArea(
                    child: GestureDetector(
                      onTap: () => print('确认签名并发送'),
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setWidth(40),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '确认签名并发送',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(14)),
                        )),
                    ),
                    bottom: true),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  /// 诊断
  Widget _buildZhenduanWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(15),
          ScreenUtil().setWidth(10),
          ScreenUtil().setWidth(15),
          ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(ImageHelper.wrapAssets('icon_zhenduan.png'),
                  width: ScreenUtil().setWidth(15),
                  height: ScreenUtil().setWidth(15)),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text(
                '诊断',
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setWidth(10)),
          Offstage(
            offstage: widget.isWeChat,
            child: Row(
              children: <Widget>[
                Text('手机', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(10)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 0.5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 0.5)),
                      hintText: '请输入患者手机号',
                      hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontSize: ScreenUtil().setSp(14))),
                  controller: _phoneController,
                  maxLines: 1,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                ))
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Row(
                    children: <Widget>[
                      Text('患者',
                          style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setWidth(10)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[300], width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[300], width: 0.5)),
                            hintText: '请输入患者姓名',
                            hintStyle: TextStyle(
                                color: Colors.grey[300],
                                fontSize: ScreenUtil().setSp(14))),
                        controller: _nameController,
                        maxLines: 1,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                      ))
                    ],
                  )),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => showCupertinoModalPopup(
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
                      Text(_gender.isEmpty ? '性别' : _gender,
                          style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      SizedBox(width: ScreenUtil().setWidth(3)),
                      Image.asset(ImageHelper.wrapAssets('icon_jiantou.png'),
                          width: ScreenUtil().setWidth(10),
                          height: ScreenUtil().setWidth(10))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setWidth(5)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 0.5)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 0.5)),
                          hintText: '年龄',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(14))),
                      controller: _ageController,
                      maxLines: 1,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                    )),
                    Text('岁',
                        style: TextStyle(fontSize: ScreenUtil().setSp(14)))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text('病症', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(10)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 0.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 0.5)),
                    hintText: '填写中医病症名称（必填）',
                    hintStyle: TextStyle(
                        color: Colors.grey[300],
                        fontSize: ScreenUtil().setSp(14))),
                controller: _diseaseController,
                maxLines: 1,
                textInputAction: TextInputAction.newline,
                style: TextStyle(fontSize: ScreenUtil().setSp(14)),
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Text('辩证', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(10)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 0.5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 0.5)),
                      hintText: '请输入主诉、辩证（选填）',
                      hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontSize: ScreenUtil().setSp(14))),
                  controller: _chiefComplaintController,
                  maxLines: 1,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                ),
              )
            ],
          ),
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

  /// 开方
  Widget _buildKaifangWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(15),
          ScreenUtil().setWidth(10),
          ScreenUtil().setWidth(15),
          ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: ProviderWidget<CategoryModel>(
        model: CategoryModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('icon_kaifang.png'),
                            width: ScreenUtil().setWidth(15),
                            height: ScreenUtil().setWidth(15)),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Text(
                          '开方',
                          style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                        ),
                      ],
                    ),
                  ],
                ),
                Text('存为常用处方',
                    style: TextStyle(
                        color: Color(0xffeaaf4c),
                        fontSize: ScreenUtil().setSp(12)))
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: model.isBusy
                    ? SizedBox.shrink()
                    : DrugStoreItem(drugs: _drugs)),
            Image.asset(ImageHelper.wrapAssets('xuxian.png')),
            Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('R:',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.w500)),
                    Offstage(
                      offstage: model.currentCategory != 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isKeLiCount = !isKeLiCount;
                          });
                        },
                        child: Text(isKeLiCount?'显示饮片克数':'显示颗粒克数',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor)),
                      ),
                    )
                  ],
                )
            ),
            _drugs.isEmpty
                ? SizedBox.shrink()
                : Stack(
                    children: <Widget>[
                      Image.asset(ImageHelper.wrapAssets('kuang_left.png'),
                          width: ScreenUtil().setWidth(12),
                          height: ScreenUtil().setWidth(12)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        color: Color(0x26eedd8f),
                        child: Wrap(
                          spacing: 15,
                          children: _buildDrugWidgets(),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Image.asset(
                            ImageHelper.wrapAssets('kuang_right.png'),
                            width: ScreenUtil().setWidth(12),
                            height: ScreenUtil().setWidth(12)),
                      )
                    ],
                  ),
            SizedBox(height: ScreenUtil().setWidth(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '共${_drugs.length}味药，总重${(_drugs.fold(0, (pre, e) => pre + (e.unitCount == null ? e.count : e.unitCount))) * int.parse(_controller.text)}克',
                    style: TextStyle(
                        color: Color(0xffeaaf4c),
                        fontSize: ScreenUtil().setSp(13))),
                GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                            ImageHelper.wrapAssets('icon_bianjiyaocia.png'),
                            width: ScreenUtil().setWidth(15),
                            height: ScreenUtil().setWidth(15)),
                        SizedBox(width: ScreenUtil().setWidth(2)),
                        Text(
                          '编辑药材',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: ScreenUtil().setSp(15)),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<CategoryModel>.value(
                                      value: model,
                                      child: EditDrugPage(
                                          drugs: _drugs)))).then((data) {
                        if (data != null) {
                          setState(() {
                            _drugs = data;
                            _drugPrice = _getSingleDrugPrice(_drugs);
                            poisons.clear();
                            conflicts.clear();
                            _drugs.forEach((drug) {
                              if (drug.name == '制草乌' && drug.count > 3) {
                                poisons.add(Poison('制草乌', '3.0'));
                              }
                            });
                            var names =
                                _drugs.map((drug) => drug.name).toList();
                            if (names.contains('川乌') && names.contains('川贝母')) {
                              conflicts.add(Conflict('川乌', '川贝母'));
                            }
                            if (names.contains('制草乌') &&
                                names.contains('川贝母')) {
                              conflicts.add(Conflict('制草乌', '川贝母'));
                            }
                          });
                        }
                      });
                    })
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(10)),
            Image.asset(ImageHelper.wrapAssets('xuxian.png')),
            SizedBox(height: ScreenUtil().setWidth(5)),
            _buildCountWidget(model.selectedCategory),
            Offstage(
                offstage: model.currentCategory != 0,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setWidth(10)),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text('煎药方式',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14)))),
                        Row(
                          children: <Widget>[
                            _buildTisnaWayButton(0, '自煎'),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            _buildTisnaWayButton(1, '代煎')
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setWidth(10)),
                    Divider(height: 0.5, color: Colors.grey[400]),
                  ],
                )),
            Offstage(
              offstage: model.currentCategory != 3,
              child: Column(
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setWidth(10)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('膏方辅料选择',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14)))),
                      Row(
                        children: <Widget>[
                          _buildFuLiaoButton(0, '蜂蜜'),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          _buildFuLiaoButton(1, '木糖醇')
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setWidth(10)),
                ],
              ))
          ],
        ),
      ),
    );
  }

  /// 毫升数
  List<Widget> _buildCountOfBagActions() {
    final List<String> mls = ['50', '100', '150', '200', '250'];
    return mls
        .map((ml) => CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _ml = ml;
              });
              Navigator.maybePop(context);
            },
            child: Text(ml)))
        .toList();
  }

  /// 药品列表
  List<Widget> _buildDrugWidgets() {
    return _drugs
        .map((drug) => Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
            child: Text(
              '${drug.name}${drug.count}${drug.unit}',
              style: TextStyle(fontSize: ScreenUtil().setSp(13)),
            )))
        .toList();
  }

  /// 根据类型显示不同数量
  Widget _buildCountWidget(int category) {
    Widget widget = SizedBox.shrink();
    switch (category) {
      case 0:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 55),
                _buildDrugUseCountWidget(_bagController..text = _countOfBag.isEmpty?'2':_countOfBag, '，每剂', '袋', '每剂袋数'),
                Row(
                  children: <Widget>[
                    Text('，每袋', style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: ()=> showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          message: Text('请选择'),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.maybePop(context),
                            child: Text('取消')),
                          actions: _buildCountOfBagActions(),
                        )),
                      child:  Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                        height: ScreenUtil().setWidth(30),
                        width: ScreenUtil().setWidth(38),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300], width: 0.5))
                        ),
                        child: Text(_ml,style: TextStyle(color: Theme.of(context).primaryColor))
                      ),
                    ),
                    Text('ml', style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_countOfDayController..text = _countOfDay.isEmpty?'3':_countOfDay, '每日', '次，', '每天服药次数'),
                _buildDrugUseCountWidget(_countOfUseDrugController..text = _countOfUse.isEmpty?'1':_countOfUse, '每次', '袋', '每次服药数量'),
              ],
            )
          ],
        );
        break;
      case 1:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 55),
                _buildDrugUseCountWidget(_bagController..text = _countOfBag.isEmpty?'2':_countOfBag, '，每剂', '袋', '每剂袋数')
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_countOfDayController..text = _countOfDay.isEmpty?'2':_countOfDay, '每日', '次，', '每天服药次数'),
                _buildDrugUseCountWidget(_countOfUseDrugController..text = _countOfUse.isEmpty?'1':_countOfUse, '每次', '袋', '每次服药数量'),
              ],
            )
          ],
        );
        break;
      case 2:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 58),
                SizedBox(width: ScreenUtil().setWidth(10)),
                GestureDetector(
                  onTap: (){
                    showDialog( context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return TipDialog();
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text('*建议处方重量在1kg以上 ',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey)),
                      Image.asset(ImageHelper.wrapAssets('icon_shuoming.png'),width: ScreenUtil().setWidth(15),height: ScreenUtil().setWidth(15)),
                    ],
                  )
                )
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_countOfDayController..text = _countOfDay.isEmpty?'3':_countOfDay, '每日', '次，', '每天服药次数'),
                _buildDrugUseCountWidget(_countOfUseDrugController..text = _countOfUse.isEmpty?'10':_countOfUse, '每次', '克', '每次服药数量'),
              ],
            )
          ],
        );
        break;
      case 3:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 55),
                SizedBox(width: ScreenUtil().setWidth(20)),
                Row(
                  children: <Widget>[
                    _buildPackButton(0, '袋装(10-15ml)'),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    _buildPackButton(1, '瓶装(180ml)')
                  ],
                )
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_countOfDayController..text = _countOfDay.isEmpty?'3':_countOfDay, '每日', '次，', '每天服药次数'),
                _buildDrugUseCountWidget(_bagController..text = _countOfBag.isEmpty?'1':_countOfBag, '每次', '袋', '每次服药数量'),
              ],
            )
          ],
        );
        break;
      case 4:
        widget = Row(
          children: <Widget>[
            _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 55),
            _buildDrugUseCountWidget(
              _countOfDayController..text = _countOfDay.isEmpty?'3':_countOfDay, '，每日', '次', '每天服药次数')
          ],
        );
        break;
      case 5:
      case 6:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 55),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Text('*每丸约0.09克',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey)),
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_countOfDayController..text = _countOfDay.isEmpty?'2':_countOfDay, '每日', '次，', '每天服药次数'),
                _buildDrugUseCountWidget(_countOfUseDrugController..text = _countOfUse.isEmpty?'1':_countOfUse, '每次', '丸', '每次服药数量'),
              ],
            )
          ],
        );
        break;
      case 7:
        widget = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_controller, '共', '剂', '处方剂量',width: 55),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Text('*每丸约9克',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey)),
              ],
            ),
            SizedBox(height: ScreenUtil().setWidth(5)),
            Row(
              children: <Widget>[
                _buildDrugUseCountWidget(_countOfDayController..text = _countOfDay.isEmpty?'2':_countOfDay, '每日', '次，', '每天服药次数'),
                _buildDrugUseCountWidget(_countOfUseDrugController..text = _countOfUse.isEmpty?'1':_countOfUse, '每次', '丸', '每次服药数量'),
              ],
            )
          ],
        );
        break;
    }
    return widget;
  }

  /// 用药输入框
  Widget _buildDrugUseCountWidget(TextEditingController controller,
      String text1, String text2, String toastText,{ num width = 40 }) {
    return Row(
      children: <Widget>[
        Text(text1, style: TextStyle(color: Colors.grey)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
          height: ScreenUtil().setWidth(30),
          width: ScreenUtil().setWidth(width),
          child: TextField(
            textAlign: TextAlign.center,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: controller,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              if (text.isEmpty || int.parse(text) < 1) {
                showToast('$toastText最小为1');
                controller.text = '';
              }else{
                if(controller == _bagController){
                  _countOfBag = text;
                }else if(controller == _countOfUseDrugController){
                  _countOfUse = text;
                }else if(controller == _countOfDayController){
                  _countOfDay = text;
                }
              }
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Colors.grey[300], width: 0.5)),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Colors.grey[300], width: 0.5)),
              contentPadding: EdgeInsets.only(bottom:ScreenUtil().setWidth(18))),
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
        Text(text2, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  /// 超量与配伍禁忌
  Widget _buildExcessWidget(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //标题
                Row(
                  children: <Widget>[
                    Image.asset(ImageHelper.wrapAssets('icon_pwjj.png'),
                        width: ScreenUtil().setWidth(15),
                        height: ScreenUtil().setWidth(15)),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Text(
                      '超量与配伍禁忌',
                      style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildExcessItem()),
                Divider(height: 0.5, color: Colors.grey[400]),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_isConfirm ? '已确认签字' : '请您签字确认以上药材使用无误',
                        style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                    Offstage(
                      offstage: _isConfirm,
                      child: GestureDetector(
                        child: Container(
                            width: ScreenUtil().setWidth(70),
                            height: ScreenUtil().setWidth(23),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                            child: Center(
                              child: Text(
                                '签名使用',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                            )),
                        onTap: () {
                          setState(() {
                            _isConfirm = true;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                right: 1,
                bottom: 1,
                child: Offstage(
                  offstage: !_isConfirm,
                  child: Transform.rotate(
                    angle: pi / 12,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets('zhang.png'),
                            width: ScreenUtil().setWidth(80),
                            height: ScreenUtil().setWidth(80)),
                        Text('许洪亮',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: ScreenUtil().setSp(16)))
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }

  /// 医嘱
  Widget _buildYizhuWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          //标题
          Row(
            children: <Widget>[
              Image.asset(ImageHelper.wrapAssets('icon_yizhu_small.png'),
                  width: ScreenUtil().setWidth(15),
                  height: ScreenUtil().setWidth(15)),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text(
                '医嘱',
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setWidth(10)),
          //用药方法
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text('用药方法',
                        style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                Row(
                  children: <Widget>[
                    _buildWayButton(0, '内服'),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    _buildWayButton(1, '外用')
                  ],
                )
              ],
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[400]),
          //用药医嘱
          GestureDetector(
            onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => DialogYiZhuSelect([
                      '饭前半小时服',
                      '饭后半小时服',
                      '空腹服',
                      '睡前服',
                      '晨起服'
                    ], [
                      '备孕禁用',
                      '怀孕禁用',
                      '经期停用',
                      '感冒停用',
                      '忌西药通用',
                      '辛辣',
                      '油腻',
                      '生冷',
                      '烟酒',
                      '发物',
                      '荤腥',
                      '酸涩',
                      '刺激性食物',
                      '光敏性食物',
                      '难消化食物'
                    ],
                        selectTimeList: _yizhuTime
                            .split(',')
                            .where((item) => item.isNotEmpty)
                            .toList(),
                        selectJiKouList: _yizhuJiKou
                            .split(',')
                            .where((item) => item.isNotEmpty)
                            .toList(), onConfirm: (time, jiKou) {
                      setState(() {
                        _yizhuTime = time;
                        _yizhuJiKou = jiKou;
                      });
                    })),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Text('用药医嘱',
                      style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                    alignment: Alignment.centerRight,
                    child: Text(
                        _yizhuTime.isEmpty && _yizhuJiKou.isEmpty
                            ? '选填'
                            : _yizhuTime.isEmpty
                                ? _yizhuJiKou
                                : _yizhuJiKou.isEmpty
                                    ? _yizhuTime
                                    : _yizhuTime + ',' + _yizhuJiKou,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: _yizhuTime.isEmpty && _yizhuJiKou.isEmpty
                                ? Colors.grey
                                : null,
                            fontSize: ScreenUtil().setSp(14))),
                  )),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[400]),
          //补充医嘱
          GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(RouteName.prescriptionYiZhu,
                    arguments: _yizhuBuChong)
                .then((result) {
              if (result != null) {
                setState(() {
                  _yizhuBuChong = result;
                });
              }
            }),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text('补充医嘱',
                          style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                  Text(_yizhuBuChong.isEmpty ? '选填' : _yizhuBuChong,
                      style: TextStyle(
                          color: _yizhuBuChong.isEmpty ? Colors.grey : null,
                          fontSize: ScreenUtil().setSp(14))),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[400]),
        ],
      ),
    );
  }

  /// 包装按钮
  Widget _buildPackButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => packWay = index),
      child: SizedBox(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setWidth(20),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(
              color: packWay == index ? Colors.white : Colors.grey[400],
              fontSize: ScreenUtil().setSp(12))),
          decoration: BoxDecoration(
            border: packWay == index
              ? null
              : Border.all(color: Colors.grey[400], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: packWay == index
              ? Theme.of(context).primaryColor
              : Colors.white),
        ),
      ),
    );
  }

  /// 膏方辅料选择按钮
  Widget _buildFuLiaoButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => gaoAssist = index),
      child: SizedBox(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(20),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(
              color: gaoAssist == index ? Colors.white : Colors.grey[400],
              fontSize: ScreenUtil().setSp(12))),
          decoration: BoxDecoration(
            border: gaoAssist == index
              ? null
              : Border.all(color: Colors.grey[400], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: gaoAssist == index
              ? Theme.of(context).primaryColor
              : Colors.white),
        ),
      ),
    );
  }

  /// 煎药方式按钮
  Widget _buildTisnaWayButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => tisnaWay = index),
      child: SizedBox(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(20),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
              style: TextStyle(
                  color: tisnaWay == index ? Colors.white : Colors.grey[400],
                  fontSize: ScreenUtil().setSp(12))),
          decoration: BoxDecoration(
              border: tisnaWay == index
                  ? null
                  : Border.all(color: Colors.grey[400], width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: tisnaWay == index
                  ? Theme.of(context).primaryColor
                  : Colors.white),
        ),
      ),
    );
  }

  /// 服用方式按钮
  Widget _buildWayButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => wayChecked = index),
      child: SizedBox(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(20),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
              style: TextStyle(
                  color: wayChecked == index ? Colors.white : Colors.grey[400],
                  fontSize: ScreenUtil().setSp(12))),
          decoration: BoxDecoration(
              border: wayChecked == index
                  ? null
                  : Border.all(color: Colors.grey[400], width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: wayChecked == index
                  ? Theme.of(context).primaryColor
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
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(20),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
              style: TextStyle(
                  color: showChecked == index ? Colors.white : Colors.grey[400],
                  fontSize: ScreenUtil().setSp(12))),
          decoration: BoxDecoration(
              border: showChecked == index
                  ? null
                  : Border.all(color: Colors.grey[400], width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: showChecked == index
                  ? Theme.of(context).primaryColor
                  : Colors.white),
        ),
      ),
    );
  }

  /// 划价
  Widget _buildHuajiaWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          // 标题
          Row(
            children: <Widget>[
              Image.asset(ImageHelper.wrapAssets('icon_huajia.png'),
                  width: ScreenUtil().setWidth(15),
                  height: ScreenUtil().setWidth(15)),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text(
                '划价',
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setWidth(10)),
          // 设置诊费
          GestureDetector(
            onTap: () {
//              showModalBottomSheet(
//                  context: context,
//                  isScrollControlled: true,
//                  builder: (context) => ZhenFeiDialog(
//                      selected: _zhenfei == 0 ? '免费' : _zhenfei.toString(),
//                      isHide: _isHide,
//                      onConfirm: (data, isHide) {
//                        setState(() {
//                          _zhenfei = data == '免费' ? 0 : int.parse(data);
//                          _isHide = isHide;
//                        });
//                      }));
              Navigator.push(context, PopRoute(child:ZhenFeiDialog(
                selected: _zhenfei == 0 ? '免费' : _zhenfei.toString(),
                isHide: _isHide,
                onConfirm: (data, isHide) {
                  setState(() {
                    _zhenfei = data == '免费' ? 0 : int.parse(data);
                    _isHide = isHide;
                  });
                })));
            },
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Row(children: <Widget>[
                    Text('设置诊费',
                        style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                    Offstage(
                      offstage: !_isHide,
                      child: Text('（附加到药费展示）',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: ScreenUtil().setSp(13))),
                    ),
                  ])),
                  Text('${_zhenfei == 0 ? '免费' : '￥$_zhenfei'}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[400]),
          // 单次处方服务费
          GestureDetector(
            onTap: () {
              if (_drugs.isEmpty) {
                showToast('请先编辑处方药材!');
              } else {
                Picker(
                    selecteds: [
                      isDefaultPercent ? 0 : _currentPercent ~/ 5 + 1
                    ],
                    title: '单次处方服务费',
                    adapter: PickerDataAdapter<String>(
                      pickerdata:
                          _getSingleServicePriceList(getTotalDrugPrice()),
                    ),
                    itemExtent: ScreenUtil().setWidth(45),
                    selectedTextStyle: TextStyle(color: Colors.black),
                    onConfirm: (Picker picker, List value) {
                      setState(() {
                        isDefaultPercent = value[0] == 0;
                        _currentPercent = isDefaultPercent
                            ? _defaultPercent
                            : (value[0] - 1) * 5;
                      });
                    }).showModal(context);
              }
            },
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text('单次处方服务费',
                          style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                  Text(
                      isDefaultPercent
                          ? '系统默认'
                          : '￥${_getSingleServicePrice()}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[400]),
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
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                          '处方合计：${(getTotalDrugPrice() + _zhenfei + _getSingleServicePrice() + _jiagongfei).toStringAsFixed(2)}元',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(14)))),
                  Text(isShowPriceDetail ? '收起' : '明细',
                      style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[400]),
          // 明细
          Offstage(
            offstage: !isShowPriceDetail,
            child: Column(
              children: <Widget>[
                SizedBox(height: ScreenUtil().setWidth(10)),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('药费',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: ScreenUtil().setSp(13))),
                        Text(
                            '￥$_drugPrice x ${_controller.text}剂 = ￥${(getTotalDrugPrice()).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('诊费',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: ScreenUtil().setSp(13))),
                            Offstage(
                              offstage: !_isHide,
                              child: Text('（附加到药费展示）',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: ScreenUtil().setSp(12))),
                            )
                          ],
                        ),
                        Text('￥$_zhenfei',
                            style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('单次处方服务费',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: ScreenUtil().setSp(13))),
                            Text('（附加到药费展示）',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: ScreenUtil().setSp(12))),
                          ],
                        ),
                        Text('￥${_getSingleServicePrice()}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('处方加工费',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: ScreenUtil().setSp(13))),
                        Text('￥$_jiagongfei',
                            style: TextStyle(fontSize: ScreenUtil().setSp(13))),
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
  double getTotalDrugPrice() {
    return _drugPrice * int.parse(_controller.text);
  }

  /// 单次处方服务费
  int _getSingleServicePrice() {
    return getTotalDrugPrice() * _currentPercent ~/ 100;
  }

  /// 单剂药品价格
  double _getSingleDrugPrice(List<Drug> drugs) {
    return drugs == null
        ? 0
        : drugs.fold(0, (pre, e) => (pre + e.price * e.count));
  }

  /// 单次处方服务费对话框选项
  List<String> _getSingleServicePriceList(double price) {
    List<String> data = List();
    for (int i = 0; i <= 100; i += 5) {
      data.add('￥${price * i ~/ 100}（药费$i%）');
    }
    data.insert(
        0, '系统默认￥${price * _defaultPercent ~/ 100}（药费$_defaultPercent%）');
    return data;
  }

  List<Widget> _buildExcessItem() {
    List<Widget> widgets = List();
    widgets.addAll(conflicts.map((conflict) {
      return Padding(
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
          child: RichText(
            text: TextSpan(
                text: conflict.name1,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(12)),
                children: <TextSpan>[
                  TextSpan(
                      text: '和',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black)),
                  TextSpan(
                    text: conflict.name2,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: '配伍禁忌',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12), color: Colors.black),
                  )
                ]),
          ));
    }).toList());
    widgets.addAll(poisons.map((poison) {
      return Padding(
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
          child: RichText(
            text: TextSpan(
                text: poison.name,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(12)),
                children: <TextSpan>[
                  TextSpan(
                      text: '超出限量(',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black)),
                  TextSpan(
                    text: '限量${poison.maxCount}克',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: ')',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12), color: Colors.black),
                  )
                ]),
          ));
    }).toList());
    return widgets;
  }
}
