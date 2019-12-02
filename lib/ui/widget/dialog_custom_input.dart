import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

class CustomInputDialog extends StatefulWidget {
  final String title;
  final String hint;
  final String content;
  final String label;
  final int maxValue;
  final String cancelText;
  final String confirmText;
  final TextInputType keyboardType;
  final Function(String) onPressed;
  final VoidCallback onCancelPressed;


  CustomInputDialog({this.title,this.hint,
    this.content = '',
    this.label = '',
    this.maxValue,
    this.cancelText = '取消',
    this.confirmText = '确定',
    this.keyboardType,
    this.onPressed,
    this.onCancelPressed});

  @override
  State<StatefulWidget> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog>{
  final TextEditingController _controller = TextEditingController();
  @protected
  void initState() {
    super.initState();
    _controller.value = TextEditingValue(
      // 设置内容
      text: widget.content,
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: widget.content.length)));
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(onTap: () => FocusScope.of(context).requestFocus(FocusNode())),
            Center(
              child: Container(
                margin: EdgeInsets.all(45),
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(15),child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      color: Colors.white,
                      child:TextField(
                        inputFormatters:widget.keyboardType == TextInputType.number ?  [
                          WhitelistingTextInputFormatter.digitsOnly
                        ] : null,
                        controller: _controller,
                        maxLines: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                          hintText: widget.hint,
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey,)
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: widget.keyboardType != null? widget.keyboardType : null,
                        style: TextStyle(fontSize: 14),
                      )
                    ),
                    SizedBox(height: 15),
                    Divider(height: 0.5, color: Colors.grey[400]),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onCancelPressed != null) {
                                  widget.onCancelPressed();
                                }
                                Navigator.maybePop(context);
                              },
                              child: Text(widget.cancelText, textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey))
                            ),
                          ),
                          Container(width: 0.5, height: 20, color: Colors.grey[400]),
                          Expanded(
                            child: GestureDetector(
                              onTap:(){
                                if(widget.label.isNotEmpty && _controller.text.isEmpty){
                                  showToast('请输入${widget.label}');
                                }else{
                                  if(widget.maxValue != null && int.parse(_controller.text) > widget.maxValue){
                                    showToast('最大可设置${widget.maxValue}');
                                    _controller.text = '${widget.maxValue}';
                                  }else{
                                    widget.onPressed(_controller.text);
                                    Navigator.maybePop(context);
                                  }
                                }
                              },
                              child: Text(widget.confirmText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme
                                    .of(context)
                                    .primaryColor)),
                            ),
                          ),
                        ],
                      ))
                  ],
                )),
            ),
          ],
        ),
      ),
    );
  }


}