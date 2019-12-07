

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class EditUserPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage>{

  String _gender = '男';
  String _level = '执业医师';
  String _type = '内科';
  String _myGoods = '内科';
  String _desc = '我是执业中医师，您有什么日常身体疾病需要帮助，可以给我图文留言或者电话咨询！';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TitleBar.buildCommonAppBar(context, '编辑个人资料'),
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setWidth(10)),
          GestureDetector(
            onTap:(){
              showDialog(context: context,barrierDismissible: false,builder:(context){
                return CupertinoAlertDialog(
                  content: Text('姓名不可以更改'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text("确定"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]
                );
              });
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              color: Colors.white,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Text('姓名',style: TextStyle(fontSize: ScreenUtil().setSp(15)))),
                  Row(
                    children: <Widget>[
                      Text('许洪亮',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      SizedBox(width: 7,height: 14)
                    ],
                  )
                ],
              )
            ),
          ),
          Divider(height: 0.5,color:Colors.grey[400]),
          GestureDetector(
            onTap:()=>showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                message: Text('请选择'),
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('取消')),
                actions: _buildGenderActions(),
              )),
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              color: Colors.white,
              child:  Row(
                children: <Widget>[
                  Expanded(child: Text('性别',style: TextStyle(fontSize: ScreenUtil().setSp(15)))),
                  Row(
                    children: <Widget>[
                      Text(_gender,style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 7,height: 14)
                    ],
                  )
                ],
              )
            ),
          ),
          Divider(height: 0.5,color:Colors.grey[400]),
          GestureDetector(
            onTap:() =>  showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                message: Text('请选择'),
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.maybePop(context),
                  child: Text('取消')),
                actions: _buildLevelActions(),
              )),
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('职称',style: TextStyle(fontSize: ScreenUtil().setSp(15)))),
                  Row(
                    children: <Widget>[
                      Text(_level,style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 7,height: 14)
                    ],
                  )
                ],
              )
            ),
          ),
          Divider(height: 0.5,color:Colors.grey[400]),
          GestureDetector(
            onTap:() => Navigator.of(context).pushNamed(RouteName.selectUserOffice,arguments: _type).then((text){
              if(text != null){
                setState(() {
                  _type = text;
                });
              }
            }),
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('所在科室',style: TextStyle(fontSize: ScreenUtil().setSp(15)))),
                  Row(
                    children: <Widget>[
                      Text(_type,style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 7,height: 14)
                    ],
                  )
                ],
              )
            ),
          ),
          SizedBox(height: ScreenUtil().setWidth(10)),
          GestureDetector(
            onTap:() => Navigator.of(context).pushNamed(RouteName.editUserGoodAt,arguments: _myGoods).then((text){
              if(text != null){
                setState(() {
                  _myGoods = text;
                });
              }
            }),
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              color: Colors.white,
              child:  Row(
                children: <Widget>[
                  Expanded(child: Text('擅长',style: TextStyle(fontSize: ScreenUtil().setSp(15)))),
                  Row(
                    children: <Widget>[
                      Text('编辑',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 7,height: 14)
                    ],
                  )
                ],
              )
            ),
          ),
          Divider(height: 0.5,color:Colors.grey[400]),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            color: Colors.white,
            child: Text(_myGoods,style: TextStyle(fontSize: ScreenUtil().setSp(13))),
          ),
          SizedBox(height: ScreenUtil().setWidth(10)),
          GestureDetector(
            onTap:() => Navigator.of(context).pushNamed(RouteName.editUserDesc,arguments: _desc).then((text){
              if(text != null){
                setState(() {
                  _desc = text;
                });
              }
            }),
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              color: Colors.white,
              child:  Row(
                children: <Widget>[
                  Expanded(child: Text('个人简介',style: TextStyle(fontSize: ScreenUtil().setSp(15)))),
                  Row(
                    children: <Widget>[
                      Text('编辑',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 7,height: 14)
                    ],
                  )
                ],
              )
            ),
          ),
          Divider(height: 0.5,color:Colors.grey[400]),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            color: Colors.white,
            child: Text('$_desc',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: RichText(
              text: TextSpan(
                text: '*',
                style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor),
                children: [
                  TextSpan(
                    text: '温馨提示：请确保填写信息真实有效，一旦发现虚假信息，造成损失，药匣子有权追究其全部责任。',
                    style: TextStyle(fontSize: ScreenUtil().setSp(12),color:Colors.grey[400])
                  )
                ]
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setWidth(20)),
          GestureDetector(
            onTap: (){
              showToast('修改成功');
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              width: double.infinity,
              height: ScreenUtil().setWidth(40),
              alignment: Alignment.center,
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              decoration: BoxDecoration(
                color: Theme
                  .of(context)
                  .primaryColor,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                '保存',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
              )
            ),
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
      child: Text(gender))).toList();
  }

  List<Widget> _buildLevelActions() {
    final List<String> levels = [
      '国医大师',
      '名中医',
      '主任医师',
      '副主任医师',
      '主治医师',
      '执业医师',
    ];
    return levels
      .map((level) => CupertinoActionSheetAction(
      onPressed: () {
        setState(() {
          _level = level;
        });
        Navigator.maybePop(context);
      },
      child: Text(level)))
      .toList();
  }
}