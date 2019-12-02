import 'package:flutter/material.dart';

class FriendNameInputDialog extends Dialog {
  final String data;
  final Function(String) onConfirm;

  FriendNameInputDialog({@required this.data, this.onConfirm});



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
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          controller: _controller,
                          maxLines: 1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey, width: 1)),
                            hintText: '请输入备注名称',
                            hintStyle: TextStyle(fontSize: 14, color: Color(0xFFcccccc),)
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text('患者姓名不能为空!', style: TextStyle(color:Theme.of(context).primaryColor)),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
                            ),
                            child: Text('跳过',style: TextStyle(color:Colors.grey[700],fontSize: 16))
                          ),
                          onTap: () => Navigator.maybePop(context))),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme
                                .of(context)
                                .primaryColor,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                            ),
                            child: Text('确定', style: TextStyle(color: Colors
                              .white,fontSize: 16)),
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
