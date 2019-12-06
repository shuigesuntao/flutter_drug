import 'package:flutter/material.dart';
import 'package:flutter_drug/model/doctor_advice.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditDoctorAdvicePage extends StatefulWidget {

  final DoctorAdvice advice;

  EditDoctorAdvicePage({this.advice});

  @override
  State<StatefulWidget> createState() => EditDoctorAdvicePageState();

}

class EditDoctorAdvicePageState extends State<EditDoctorAdvicePage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
      text: widget.advice?.content ?? "",
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.advice?.content?.length ?? 0))));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, widget.advice == null ? '新建医嘱' : '修改医嘱',actionText: '保存',onActionPress: () {
          print(_controller.text);
        }),
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child:  Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(15)),
            child: TextField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                //去掉输入框的下滑线
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                filled: true,
                hintText: "请填写医嘱内容（最多500字）",
                hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(16)),
                counterStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(16)),
                enabledBorder: null,
                disabledBorder: null),
              controller: _controller,
              maxLength: 500,
              maxLines: 10,
            ),
          )
        ),
      ),
    );
  }
}
