import 'package:flutter/material.dart';

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
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: GestureDetector(
                      child: Icon(Icons.close, color: Theme
                        .of(context)
                        .primaryColor, size: 15),
                      onTap: () => Navigator.maybePop(context)),
                    right: 1,
                    top: 1,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '规格说明', style: TextStyle(color: Colors.orangeAccent)),
                      SizedBox(height: 5),
                      Text('1kg以下60-80目，1kg以上200目'),
                      SizedBox(height: 15),
                      Text(
                        '损耗说明', style: TextStyle(color: Colors.orangeAccent)),
                      SizedBox(height: 5),
                      Text('1000克以上损耗占处方总重的5%-10%，1000克以下损耗占处方总重的20%-30%'),
                    ],
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