import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class CustomEditDrugBoard extends StatelessWidget{
  static CKTextInputType inputType = const CKTextInputType(name:'CKCustomEditDrugBoard');
  static double getHeight(BuildContext ctx){
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 7 * 5 / 3 /1.5 *4 + ScreenUtil.bottomBarHeight;
  }
  final KeyboardController controller ;
  const CustomEditDrugBoard({this.controller});

  static register(){
    CoolKeyboard.addKeyboard(CustomEditDrugBoard.inputType,KeyboardConfig(builder: (context,controller){
      return CustomEditDrugBoard(controller: controller);
    },getHeight: CustomEditDrugBoard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Material(
      child:  DefaultTextStyle(
        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 20),
        child: Container(
          margin: EdgeInsets.only(bottom: ScreenUtil.bottomBarHeight),
          padding: EdgeInsets.only(bottom: 1),
          height:getHeight(context),
          width: mediaQuery.size.width,
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
          child: Row(
            children: <Widget>[
              Expanded(flex:5,child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5/1,
                mainAxisSpacing:1,
                crossAxisSpacing:1,
                padding: EdgeInsets.all(1.0),
                crossAxisCount: 3,
                children: <Widget>[
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  Container(
                    color: Colors.white,
                  ),
                  buildButton('0'),
                  buildButton('.'),
                ])),
              Expanded(flex:2,child: Column(
                children: <Widget>[
                  Expanded(
                    child:Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[400],width: 1)
                        )
                      ),

                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Center(child: Image.asset(ImageHelper.wrapAssets('icon_shanchu.png'),width: 20,height: 20)),
                        onTap: (){
                          controller.deleteOne();
                        },
                      ),
                    )
                  ),
                  Expanded(
                    child:Container(
                      color: Color(0xffd80c18),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Center(child: Text('确认',style: TextStyle(color: Colors.white))),
                        onTap: (){
                          if (controller.text.isEmpty || double.parse(controller.text) == 0) {
                            showToast('数量不能为0');
                          }else{
                            controller.doneAction();
                          }
                        },
                      ),
                    )
                  )
                ],
              ))
            ],
          ),
        )
      ),
    );
  }

  Widget buildButton(String title,{String value}){
    if(value == null){
      value = title;
    }
    return Container(
      color: Colors.white,
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