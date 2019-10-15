import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

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
    if(selected != '免费'){
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
        height: 35,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: isChecked?Colors.white:Colors.grey)),
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(color: Colors.black54, height: double.infinity),
        Container(
          color: Colors.white,
          height: 230,
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: FlatButton(
                        child: Text('取消', style: TextStyle(
                          color: Colors.grey[700])),
                        onPressed: () => Navigator.maybePop(context)
                      ),
                    ),
                    Text('设置诊费'),
                    Container(
                      height: 40,
                      child: FlatButton(
                        child: Text('确定', style: TextStyle(
                          color: Theme
                            .of(context)
                            .primaryColor)),
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
                padding: EdgeInsets.fromLTRB(15,10,15,10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Text('隐藏诊费（附加到药费显示）'),
                    ),
                    Text(isHide ? '是' : '否', style: TextStyle(color: Colors.grey)),
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
                        SizedBox(width: 15),
                        Expanded(
                          child: _buildButton('50')
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: _buildButton('100')
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildButton('200')
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: _buildButton('300')
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            height: 35,
                            alignment: Alignment.center,
                            child: TextField(
                              focusNode: _focusNode,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              controller: _controller,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey,fontSize: 14),
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
                                contentPadding:EdgeInsets.all(0),
                                border: InputBorder.none,
                                hintText: '自定义',
                                hintStyle: TextStyle(fontSize: 14,color: Colors.grey)
                              ),
                              keyboardType: TextInputType.number,
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
        )
      ],
    );
  }
}
