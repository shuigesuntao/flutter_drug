

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class TitleBar {
  static AppBar buildCommonAppBar(BuildContext context, String title,{VoidCallback onPressed,String actionText,VoidCallback onActionPress,isShowBack = true,Color actionTextColor}) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(title),
      leading: isShowBack ? leading(context,onPressed) : null,
      actions: actionText == null ? null : <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: onActionPress,
            child: Center(
              child: Text(
                actionText,
                style: TextStyle(color:actionTextColor == null? Theme.of(context).primaryColor : actionTextColor),
              ),
            ),
          ))
      ],
    );
  }

  static leading(BuildContext context, VoidCallback onPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          padding: EdgeInsets.all(0),
          child: new IconButton(
            padding: EdgeInsets.only(left: 16, right: 16),
            icon: Image.asset(
              ImageHelper.wrapAssets('ic_back_black.png'),
              fit: BoxFit.contain,
              width: 16,
              height: 16,
            ),
            onPressed: () {
              if (onPressed == null) {
                Navigator.of(context).pop();
              } else {
                onPressed();
              }
            },
          ),
        ),
      ],
    );
  }

}

