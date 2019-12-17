import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'custom_number_keyboard.dart';

class ZhenFeiDialog extends StatefulWidget{
  final String selected;
  final bool isHide;
  ///确定回调事件
  final Function(String,bool) onConfirm;

  ZhenFeiDialog({this.selected,this.isHide,this.onConfirm});

  @override
  State<StatefulWidget> createState() =>_ZhenFeiDialogState(selected,isHide);

}

class _ZhenFeiDialogState extends State<ZhenFeiDialog>{

  String selected='';
  bool isHide = false;
  FocusNode _focusNode = FocusNode();

  TextEditingController _controller = TextEditingController();

  _ZhenFeiDialogState(this.selected,this.isHide);

  List<String> datas = ['免费','50','100','200','300'];
  @override
  void initState() {
    super.initState();
    if(!datas.contains(selected)){
      _controller.value = TextEditingValue(text: selected,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
          affinity: TextAffinity.downstream,
          offset:selected.length
        )));
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // TextField has lost focus
        setState(() {
          selected = '';
        });
      }
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!datas.contains(selected)){
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  Widget _buildButton(String text) {
    bool isChecked = selected == text;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _controller.text = '';
        setState(() {
          if(selected != text){
            selected = text;
          }
        });
      },
      child: Container(
        height: ScreenUtil().setWidth(35),
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: isChecked?Colors.white:Colors.grey[700])),
        decoration: BoxDecoration(
          border: isChecked
            ? null
            : Border.all(color: Colors.grey[600], width: 1),
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: isChecked
            ? Theme.of(context).primaryColor
            : Colors.white),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(
      child: Builder(builder: (ctx) {
        return Scaffold(
          backgroundColor: Colors.black54,
          body: Column(
            children: <Widget>[
              Expanded(
                child: SizedBox()
              ),
              Container(
                color: Colors.white,
                height: ScreenUtil().setWidth(230),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setWidth(40),
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: ScreenUtil().setWidth(40),
                            child: FlatButton(
                              child: Text('取消', style: TextStyle(
                                color: Colors.grey[700],fontSize: ScreenUtil().setSp(14))),
                              onPressed: () => Navigator.maybePop(context)
                            ),
                          ),
                          Text('设置诊费'),
                          Container(
                            height: ScreenUtil().setWidth(40),
                            child: FlatButton(
                              child: Text('确定', style: TextStyle(
                                color: Theme
                                  .of(context)
                                  .primaryColor,fontSize: ScreenUtil().setSp(14))),
                              onPressed: (){
                                if(selected.isEmpty){
                                  if(_controller.text.isEmpty){
                                    showToast('请设置诊费');
                                    return;
                                  }else{
                                    selected = _controller.text;
                                  }
                                }
                                widget.onConfirm(selected,isHide);
                                Navigator.maybePop(context);
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(15),ScreenUtil().setWidth(15),ScreenUtil().setWidth(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Text('隐藏诊费（附加到药费显示）'),
                          ),
                          Text(isHide ? '是' : '否', style: TextStyle(color: Colors.grey[700],fontSize: ScreenUtil().setSp(14))),
                          CupertinoSwitch(
                            activeColor: Theme.of(context).primaryColor,
                            value: isHide,
                            onChanged: (value) {
                              setState(() {
                                isHide = value;
                              });
                            },
                          )
                        ],
                      )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _buildButton('免费')
                              ),
                              SizedBox(width: ScreenUtil().setWidth(15)),
                              Expanded(
                                child: _buildButton('50')
                              ),
                              SizedBox(width: ScreenUtil().setWidth(15)),
                              Expanded(
                                child: _buildButton('100')
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setWidth(15)),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _buildButton('200')
                              ),
                              SizedBox(width: ScreenUtil().setWidth(15)),
                              Expanded(
                                child: _buildButton('300')
                              ),
                              SizedBox(width: ScreenUtil().setWidth(15)),
                              Expanded(
                                child: Container(
                                  height: ScreenUtil().setWidth(35),
                                  alignment: Alignment.center,
                                  child: TextField(
                                    focusNode: _focusNode,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _controller,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),
                                    onChanged: (text) {
                                      if (int.parse(text) > 5000) {
                                        showToast('诊费提示：最高可设置5000元');
                                        _controller.value = TextEditingValue(text: '5000',
                                          // 保持光标在最后
                                          selection: TextSelection.fromPosition(TextPosition(
                                            affinity: TextAffinity.downstream,
                                            offset:4
                                          )));
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:EdgeInsets.only(bottom: ScreenUtil().setWidth(13)),
                                      border: InputBorder.none,
                                      hintText: '自定义',
                                      hintStyle: TextStyle(fontSize: 14,color: Colors.grey[700])
                                    ),
                                    keyboardType: CustomNumberKeyBoard.inputType,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[600], width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                    color:Colors.white),
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        );
      })
    );
  }
}
