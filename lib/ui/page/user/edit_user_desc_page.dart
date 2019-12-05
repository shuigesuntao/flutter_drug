import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditUserDescPage extends StatefulWidget {

  final String desc;

  EditUserDescPage({this.desc});

  @override
  State<StatefulWidget> createState() => EditUserDescPageState();

}

class EditUserDescPageState extends State<EditUserDescPage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
      text: widget.desc?? "",
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.desc?.length ?? 0))));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, '简介',actionText: '确定',onActionPress: () {
          if(_controller.text.isEmpty){
            showDialog(context: context,barrierDismissible: false,builder:(context){
              return CupertinoAlertDialog(
                title: Text('提示'),
                content: Text('请输入简介'),
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
          }else{
            Navigator.of(context).pop(_controller.text);
          }
        }),
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child:  Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(bottom: 15),
            child: TextField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                //去掉输入框的下滑线
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
                filled: true,
                hintText: '我是执业中医师，您有什么日常身体疾病需要帮助，可以随时找我咨询',
                hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(15)),
                counterStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(15)),
                enabledBorder: null,
                disabledBorder: null),
              controller: _controller,
              maxLength: 1000,
              maxLines: 10,
            ),
          )
        ),
      ),
    );
  }
}
