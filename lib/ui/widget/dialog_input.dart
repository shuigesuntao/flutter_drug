import 'package:flutter/material.dart';

class InputDialog extends Dialog {
  final String data;
  final Function(String) onConfirm;

  InputDialog({@required this.data, this.onConfirm});



  Widget build(BuildContext context) {
    return InputDialogWidget(data: data,onConfirm:onConfirm);
  }

}

class InputDialogWidget extends StatefulWidget{
  final String data;
  final Function(String) onConfirm;

  InputDialogWidget({@required this.data, this.onConfirm});
  @override
  State<StatefulWidget> createState()=> _InputDialogWidgetState();

}

class _InputDialogWidgetState extends State<InputDialogWidget>{
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.value = TextEditingValue(
      // 设置内容
      text: widget.data,
      // 保持光标在最后
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: widget.data.length)));
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(onTap: ()=>Navigator.maybePop(context)),
          Center(
            child: Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          controller: _controller,
                          maxLines: 1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                            hintText: '请输入备注名称',
                            hintStyle: TextStyle(fontSize: 14, color: Color(0xFFcccccc),)
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text('患者姓名不能为空!', style: TextStyle(color: Colors.red))
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            color: Colors.grey[300],
                            child: Text('跳过')
                          ),
                          onTap: () => Navigator.maybePop(context))),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            color: Theme
                              .of(context)
                              .primaryColor,
                            child: Text('确定', style: TextStyle(color: Colors
                              .white)),
                          ),
                          onTap: (){
                            widget.onConfirm(_controller.text);
                            Navigator.maybePop(context);
                          }))
                    ],
                  )
                ],
              ),
            ),
          ), //构建具体的对话框布局内容
        ],
      ),
    );
  }

}
