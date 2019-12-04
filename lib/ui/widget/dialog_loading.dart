import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {

  final String text;

  LoadingDialog({ this.text});

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoActivityIndicator(radius:16),
                  SizedBox(height: 10),
                  Text(text,style: TextStyle(fontSize: 15))
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}