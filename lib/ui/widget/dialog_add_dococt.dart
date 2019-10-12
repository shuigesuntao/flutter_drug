import 'package:flutter/material.dart';

class DecoctAddDialog extends Dialog {
  final Function(String) onConfirm;
  final TextEditingController _controller = TextEditingController();

  DecoctAddDialog({this.onConfirm});

  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(onTap: ()=>Navigator.maybePop(context)),
          Center(
            child: Container(
              height: 150,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(30,20,30,20),
                    color: Colors.white,
                    child:TextField(
                      controller: _controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                        hintText: '请输入入煎方法',
                        hintStyle: TextStyle(fontSize: 14, color: Color(0xFFcccccc),)
                      ),
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: 14),
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 80,
                          height: 28,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () => Navigator.maybePop(context),
                            color: Colors.grey[300],
                            child: Text('取消',style: TextStyle(color: Colors.grey)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          ),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 80,
                          height: 28,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              onConfirm(_controller.text);
                              Navigator.maybePop(context);
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              '确定',
                              style:
                              TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          ),
                        )
                      ],
                    ),
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