import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/model/address.dart';
import 'package:flutter_drug/ui/widget/picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class EditAddressPage extends StatefulWidget {
  final Address address;

  EditAddressPage({this.address});

  @override
  State<StatefulWidget> createState() => EditAddressPageState();
}

class EditAddressPageState extends State<EditAddressPage> {
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;

  int _isDefault = 0;
  List _cityData;
  String _area;

  @override
  void initState() {
    super.initState();
    _isDefault = widget.address?.isDefault ?? 0;
    _nameController = initController(widget.address?.name ?? "");
    _phoneController = initController(widget.address?.phone ?? "");
    _addressController = initController(widget.address?.address ?? "");
    DefaultAssetBundle.of(context).loadString("assets/city.json").then((value) {
      setState(() {
        _cityData = json.decode(value);
      });
    });
    _area = widget.address?.area??'';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: TitleBar.buildCommonAppBar(
          context, widget.address == null ? '添加地址' : '编辑收货地址',
          actionText: '保存', onPressed: ()=>
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('提示'),
                content: Text('地址尚未保存是否确认退出'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text("确认"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("取消"),
                    onPressed: () => Navigator.pop(context)),
                ],
              );
            })
          ,onActionPress: () {
          widget.address?.isDefault = _isDefault;
          if(_area.isEmpty){
            showToast("请输入地区");
            return;
          }
          widget.address?.area = _area;
          Navigator.pop(context);
        }),
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            _buildItem(_nameController, '收货人', '请填写收货人姓名'),
            _buildItem(_phoneController, '手机号码', '请填写收货人手机号码',
              isNumber: true),
            GestureDetector(
              onTap: () => Picker(
                adapter: PickerDataAdapter<String>(pickerdata: _cityData),
                itemExtent: ScreenUtil().setWidth(35),
                selectedTextStyle: TextStyle(color: Colors.black),
                onConfirm: (Picker picker, List value) {
                  setState(() {
                    _area = picker.adapter.text;
                  });
                }
              ).showModal(context),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: ScreenUtil().setWidth(60), child: Text('所在地区',style: TextStyle(fontSize:ScreenUtil().setWidth(14)))),
                          SizedBox(width: ScreenUtil().setWidth(15)),
                          Expanded(
                            child: Text(
                              widget.address == null
                                ? '省市区县、乡镇等'
                                : _area,
                              style: TextStyle(color: widget.address == null ?Colors.grey: null,fontSize: ScreenUtil().setWidth(14)))),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 0.5, color: Colors.grey[400])
                  ],
                ),
              ),
            ),
            _buildItem(_addressController, '详细地址', '如道路、门牌号、小区、楼栋号、单元室等',
              maxLines: 3),
            SizedBox(height: ScreenUtil().setWidth(20)),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(12), ScreenUtil().setWidth(5), ScreenUtil().setWidth(12), ScreenUtil().setWidth(5)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('设为默认地址',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  ),
                  GestureDetector(
                    onTap: ()=> setState(() {
                      _isDefault = _isDefault == 1 ? 0 : 1;
                    }),
                    child: CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: _isDefault == 1,
                      onChanged: (value) {
                        setState(() {
                          _isDefault = value ? 1 : 0;
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  TextEditingController initController(String content) {
    return TextEditingController.fromValue(TextEditingValue(
        // 设置内容
        text: content,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: content.length))));
  }

  Widget _buildItem(TextEditingController controller, String title, String hint,
      {int maxLines = 1, bool isNumber = false}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: ScreenUtil().setWidth(60), child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                SizedBox(width: ScreenUtil().setWidth(15)),
                Expanded(
                    child: TextField(
                  inputFormatters: isNumber
                      ? [WhitelistingTextInputFormatter.digitsOnly]
                      : null,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(14)),
                      enabledBorder: null,
                      disabledBorder: null),
                  controller: controller,
                  maxLines: maxLines,
                  textInputAction: TextInputAction.next,
                  keyboardType: isNumber ? TextInputType.number : null,
                  style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                  textAlign: TextAlign.start,
                )
                )
              ],
            ),
          ),
          maxLines == 1 ? Divider(height: 0.5, color: Colors.grey[400]) : SizedBox()
        ],
      ),
    );
  }
}
