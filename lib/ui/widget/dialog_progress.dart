import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class ProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(ImageHelper.wrapAssets('lodigngif.gif'),
          width: 50, height: 50),
        SizedBox(height: 10),
        Material(
          color: Colors.transparent,
          child: Text(
            '加载中...',
            style: TextStyle(color: Colors.white,fontSize: 16),
          )
        )
      ],
    );
  }
}
