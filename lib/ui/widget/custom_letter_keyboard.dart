import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLetterKeyboard extends StatelessWidget{
  static const CKTextInputType inputType = const CKTextInputType(name:'CKCustomLetterKeyboard');
  static double getHeight(BuildContext ctx){
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 10 * 3 * 1.9;
  }
  final KeyboardController controller ;
  const CustomLetterKeyboard({this.controller});

  static register(){
    CoolKeyboard.addKeyboard(CustomLetterKeyboard.inputType,KeyboardConfig(builder: (context,controller){
      return CustomLetterKeyboard(controller: controller);
    },getHeight: CustomLetterKeyboard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Material(
      child:  DefaultTextStyle(
        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 20),
        child: Container(
          padding: EdgeInsets.only(top:5,bottom:5+ScreenUtil.bottomBarHeight),
          height:getHeight(context),
          width: mediaQuery.size.width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Column(
            children: <Widget>[
              Expanded(child: Row(
                children: <Widget>[
                  SizedBox(width: 5),
                  buildButton('Q'),
                  buildButton('W'),
                  buildButton('E'),
                  buildButton('R'),
                  buildButton('T'),
                  buildButton('Y'),
                  buildButton('U'),
                  buildButton('I'),
                  buildButton('O'),
                  buildButton('P'),
                ])),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 5),
                  buildButton('A'),
                  buildButton('S'),
                  buildButton('D'),
                  buildButton('F'),
                  buildButton('G'),
                  buildButton('H'),
                  buildButton('J'),
                  buildButton('K'),
                  buildButton('L'),
                ]
              )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          controller.doneAction();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          width: (ScreenUtil.screenWidthDp - 50 - ((ScreenUtil.screenWidthDp - 55) / 10 * 7))/2,
                          height: (ScreenUtil.screenWidthDp - 55) / 6.6,
                          child: Icon(Icons.keyboard_hide,size: 25)
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 5),
                              buildButton('Z'),
                              buildButton('X'),
                              buildButton('C'),
                              buildButton('V'),
                              buildButton('B'),
                              buildButton('N'),
                              buildButton('M'),
                            ]
                        )
                      ),
                      GestureDetector(
                        onTap: (){
                          controller.deleteOne();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          width: (ScreenUtil.screenWidthDp - 50 - ((ScreenUtil.screenWidthDp - 55) / 10 * 7))/2,
                          height: (ScreenUtil.screenWidthDp - 55) / 6.6,
                          child: Image.asset(ImageHelper.wrapAssets('keyboard_delete.png'))
                        ),
                      ),
                    ],
                  ),
                )
              )
            ],
          )
        )
      ),
    );
  }

  Widget buildButton(String title,{String value}){
    if(value == null){
      value = title;
    }
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: (ScreenUtil.screenWidthDp - 55) / 10,
      height: (ScreenUtil.screenWidthDp - 55) / 6.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(child: Text(title)),
        onTap: (){
          controller.addText(value);
        },
      ),
    );
  }
}