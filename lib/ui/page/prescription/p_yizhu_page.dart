import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:oktoast/oktoast.dart';

class PrescriptionYiZhuPage extends StatefulWidget {
  final String text;
  PrescriptionYiZhuPage({this.text});
  @override
  State<StatefulWidget> createState() => _PrescriptionYiZhuPageState();
}

class _PrescriptionYiZhuPageState extends State<PrescriptionYiZhuPage>{
  final _controller = TextEditingController();
  bool _isSave = false;

  @override
  void initState() {
    super.initState();
    _controller.value = TextEditingValue(
      // 设置内容
      text: widget.text,
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.text.length)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.buildCommonAppBar(context, '补充医嘱'),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '补充医嘱',
                    style: TextStyle(fontSize: 16),
                  )),
                Text('常用医嘱', style: TextStyle(color: Colors.red)),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  //去掉输入框的下滑线
                  fillColor: Color(0xFFF7F7F7),
                  contentPadding: EdgeInsets.all(5),
                  filled: true,
                  hintText: '请输入补充嘱咐内容',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: null,
                  disabledBorder: null),
                controller: _controller,
                maxLength: 300,
                maxLines: 6,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('填写内容保存至常用医嘱'),
                  ),
                  Text(_isSave ? '是' : '否',
                    style: TextStyle(
                      color: _isSave
                        ? Theme.of(context).primaryColor
                        : Colors.black87)),
                  CupertinoSwitch(
                    activeColor: Theme.of(context).primaryColor,
                    value:_isSave,
                    onChanged: (value) {
                      setState(() {
                        _isSave = value;
                      });
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SafeArea(child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(12),
                    onPressed: (){
                      if(_controller.text.isEmpty){
                        showToast('请输入医嘱');
                      }else{
                        Navigator.pop(context,_controller.text);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      '完成',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),bottom: true),
              ),
            )
          ],
        ),
      )
    );
  }

}
