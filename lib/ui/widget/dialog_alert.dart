

import 'package:flutter/cupertino.dart';

class DialogAlert extends StatelessWidget {

  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback onPressed;
  DialogAlert({this.title = '提示',this.content,this.cancelText = '取消',this.confirmText='确定',this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(cancelText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(confirmText),
          onPressed: onPressed,
        ),
      ],
    );
  }

}