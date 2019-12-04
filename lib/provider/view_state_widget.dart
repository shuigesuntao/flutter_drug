import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  ViewStateWidget(
      {Key key,
      this.image,
      this.message,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image ?? Icon(IconFonts.pageError, size: 80, color: Colors.grey[500]),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 150),
            child: Text(
              message ?? '加载失败',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.grey),
            ),
          ),
          ViewStateButton(
            child: buttonText,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final String image;

  const ViewStateEmptyWidget(
      {Key key,
      this.image,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageHelper.wrapAssets(image ?? 'zwsj.png')),
            Text(
              message ?? '暂无数据',
              style: TextStyle(fontSize: 16,color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

///// 页面未授权
//class ViewStateUnAuthWidget extends StatelessWidget {
//  final String message;
//  final Widget image;
//  final Widget buttonText;
//  final VoidCallback onPressed;
//
//  const ViewStateUnAuthWidget(
//      {Key key,
//      this.image,
//      this.message,
//      this.buttonText,
//      @required this.onPressed})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ViewStateWidget(
//      onPressed: this.onPressed,
//      image: image ?? ViewStateUnAuthImage(),
//      message: message ?? S.of(context).viewStateMessageUnAuth,
//      buttonText: buttonText ??
//          Text(
//            S.of(context).signIn,
//            style: TextStyle(wordSpacing: 5),
//          ),
//    );
//  }
//}

///// 未授权图片
//class ViewStateUnAuthImage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Hero(
//      tag: 'loginLogo',
//      child: Image.asset(
//        ImageHelper.wrapAssets('login_logo.png'),
//        width: 130,
//        height: 100,
//        fit: BoxFit.fitWidth,
//        color: Theme.of(context).accentColor,
//        colorBlendMode: BlendMode.srcIn,
//      ),
//    );
//  }
//}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ViewStateButton({@required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ??
          Text(
            '重试',
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}




