import 'package:flutter/material.dart';

class CustomDialogAlert extends Dialog {
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback onPressed;
  final VoidCallback onCancelPressed;

  CustomDialogAlert(
      {this.content,
      this.cancelText = '取消',
      this.confirmText = '确定',
      this.onPressed,
      this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(onTap: () => Navigator.maybePop(context)),
          Center(
            child: Container(
                margin: EdgeInsets.all(40),
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(content),
                    ),
                    Divider(height: 0.5, color: Colors.grey),
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (onCancelPressed != null) {
                                onCancelPressed();
                              }
                              Navigator.maybePop(context);
                            },
                            child: Text(cancelText,textAlign:TextAlign.center,style: TextStyle(color: Colors.grey))
                          ),
                        ),
                        Container(width: 0.5, height: 20, color: Colors.grey),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              onPressed();
                              Navigator.maybePop(context);
                            },
                            child: Text(confirmText,
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                          ),
                        ),
                      ],
                    ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
