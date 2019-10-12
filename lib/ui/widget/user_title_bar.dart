import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class UserTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String actionText;
  final VoidCallback onActionPressed;

  UserTitleBar(this.title,{this.actionText,this.onActionPressed});

  @override
  Size get preferredSize => Size.fromHeight(56.0);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(ImageHelper.wrapAssets('bg_daohang.png'))
        )
      ),
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              padding: EdgeInsets.all(0),
              child: new IconButton(
                padding: EdgeInsets.only(left: 16, right: 16),
                icon: Image.asset(
                  ImageHelper.wrapAssets('ic_back_black.png'),
                  fit: BoxFit.contain,
                  color: Colors.white,
                  width: 16,
                  height: 16,
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.maybePop(context);
                },
              ),
            ),
            Expanded(child: Center(child: Text(title,style: TextStyle(color: Colors.white,fontSize: 18)))),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                actionText,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

}
