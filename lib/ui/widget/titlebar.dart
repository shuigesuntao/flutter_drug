

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class TitleBar {
  static PreferredSize buildCommonAppBar(BuildContext context, String title,{VoidCallback onPressed,Color titleColor,String actionText,String actionIcon,List<Widget> actions,VoidCallback onActionPress,Color backColor,isShowBack = true,Color actionTextColor,Color backgroundColor = Colors.white}) {
    return PreferredSize(
      child: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(title,style: TextStyle(color: titleColor == null?Colors.black:titleColor,fontWeight: FontWeight.w500,fontSize: 18)),
        leading: isShowBack ? leading(context,onPressed,color:backColor) : null,
        actions: actions == null && actionText == null && actionIcon == null ? null : actionText != null?<Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: onActionPress,
              child: Center(
                child: Text(
                  actionText,
                  style: TextStyle(fontSize:15,color:actionTextColor == null? Theme.of(context).primaryColor : actionTextColor),
                ),
              ),
            ))
        ]: actionIcon != null?<Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: onActionPress,
              child: Center(
                child: Image.asset(ImageHelper.wrapAssets(actionIcon),width: 18,height: 18),
              ),
            )
          )
        ]:actions,
      ),
      preferredSize:Size.fromHeight(50)
    );
  }

  static leading(BuildContext context,VoidCallback onPressed,{Color color}) {
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
              color: color??null,
              width: 16,
              height: 16,
            ),
            onPressed: () {
              if (onPressed == null) {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.maybePop(context);
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

