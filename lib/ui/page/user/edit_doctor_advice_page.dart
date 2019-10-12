import 'package:flutter/material.dart';
import 'package:flutter_drug/model/doctor_advice.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

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
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, widget.advice == null ? '新建医嘱' : '修改医嘱'),
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('医嘱类型', style: TextStyle(fontSize: 18))),
                  Radio(
                    activeColor: Theme.of(context).primaryColor,
                    value: 1,
                    groupValue: widget.advice?.type ?? 1,
                    onChanged: (value) {
                      widget.advice.type = value;
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  Text('饮片', style: TextStyle(fontSize: 18))
                ],
              ),
            ),
            Container(
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
                  hintText: "请输入医嘱",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  counterStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  enabledBorder: null,
                  disabledBorder: null),
                controller: _controller,
                maxLength: 500,
                maxLines: 10,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SafeArea(
                    bottom: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        onPressed: () => print(_controller.text),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          '确定',
                          style: TextStyle(
                            color: Colors.white, fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      ),
                    )),
                )))
          ],
        ),
      ),
    );
  }
}
