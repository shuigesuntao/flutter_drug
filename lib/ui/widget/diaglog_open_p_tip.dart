import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipDialog extends StatelessWidget{
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
              height: ScreenUtil().setWidth(190),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    child: GestureDetector(
                      child: Icon(Icons.close, color: Theme
                        .of(context)
                        .primaryColor, size: ScreenUtil().setWidth(20)),
                      onTap: () => Navigator.maybePop(context)),
                    right: ScreenUtil().setWidth(10),
                    top: ScreenUtil().setWidth(10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '规格说明', style: TextStyle(color: Colors.orangeAccent,fontSize: ScreenUtil().setSp(14))),
                      SizedBox(height: ScreenUtil().setWidth(5)),
                      Text('1kg以下60-80目，1kg以上200目',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      SizedBox(height: ScreenUtil().setWidth(15)),
                      Text(
                        '损耗说明', style: TextStyle(color: Colors.orangeAccent,fontSize: ScreenUtil().setSp(14))),
                      SizedBox(height: ScreenUtil().setWidth(15)),
                      Text('1kg以下损耗占处方总重的20%-30%，\n1kg以上损耗占处方总重的5%-10%',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}