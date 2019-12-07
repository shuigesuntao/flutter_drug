
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class DialogFuzhenTime extends StatefulWidget{
  /// 标签的list
  final int fuzhenTime;
  final int suifangTime;
  final Function(int,int) onConfirm;

  DialogFuzhenTime({this.onConfirm,this.fuzhenTime,this.suifangTime});

  @override
  State<StatefulWidget> createState() => _DialogFuzhenTimeState(fuzhenTime,suifangTime);

}

class _DialogFuzhenTimeState extends State<DialogFuzhenTime>{
  int fuzhenTime;
  int suifangTime;

  _DialogFuzhenTimeState(this.fuzhenTime,this.suifangTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(ScreenUtil().setWidth(240)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(40),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setWidth(40),
                  child: FlatButton(
                    child: Text('取消', style: TextStyle(
                      color: Colors.grey[700],fontSize: ScreenUtil().setSp(14))),
                    onPressed: () => Navigator.maybePop(context)
                  ),
                ),
                Text('复诊及随访时间',style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                Container(
                  height: ScreenUtil().setWidth(40),
                  child: FlatButton(
                    child: Text('确定', style: TextStyle(
                      color: Theme
                        .of(context)
                        .primaryColor,fontSize: ScreenUtil().setSp(14))),
                    onPressed: (){
                      widget.onConfirm(fuzhenTime,suifangTime);
                      Navigator.maybePop(context);
                    }
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setWidth(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('提醒患者复诊',style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                    Row(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.translationValues(3, 0, 0),
                          child:GestureDetector(
                            onTap: (){
                              if(fuzhenTime == 0){
                                showToast('当前已设置不复诊');
                              }else{
                                setState(() {
                                  fuzhenTime--;
                                });
                              }
                            },
                            child: Image.asset(ImageHelper.wrapAssets('icon_minus1.png'),width: ScreenUtil().setWidth(28),height: ScreenUtil().setWidth(28)),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(70),
                          height: ScreenUtil().setWidth(28),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(ImageHelper.wrapAssets('rect.png')))
                          ),
                          child: Center(
                            child: Text(fuzhenTime == 0?'不设置':'$fuzhenTime 天后'),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(-3, 0, 0),
                          child: GestureDetector(
                            onTap: (){
                              if(fuzhenTime ==30){
                                showToast('最大可设置为30');
                              }else{
                                setState(() {
                                  fuzhenTime++;
                                });
                              }
                            },
                            child: Image.asset(ImageHelper.wrapAssets('icon_add1.png'),width: ScreenUtil().setWidth(28),height: ScreenUtil().setWidth(28)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Text('*系统将通过【药匣子在线】公众号给予自动给予该患者复诊提醒。',style: TextStyle(fontSize: 12,color: Colors.grey)),
                SizedBox(height: ScreenUtil().setWidth(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('设置随访时间',style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                    Row(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.translationValues(3, 0, 0),
                          child:GestureDetector(
                            onTap: (){
                              if(suifangTime == 0){
                                showToast('当前已设置不随访');
                              }else{
                                setState(() {
                                  suifangTime--;
                                });
                              }
                            },
                            child: Image.asset(ImageHelper.wrapAssets('icon_minus1.png'),width: ScreenUtil().setWidth(28),height: ScreenUtil().setWidth(28)),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(70),
                          height: ScreenUtil().setWidth(28),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(ImageHelper.wrapAssets('rect.png')))
                          ),
                          child: Center(

                            child: Text(suifangTime == 0?'不设置':'$suifangTime 天后'),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(-3, 0, 0),
                          child:GestureDetector(
                            onTap: (){
                              if(suifangTime ==30){
                                showToast('最大可设置为30');
                              }else{
                                setState(() {
                                  suifangTime++;
                                });
                              }
                            },
                            child: Image.asset(ImageHelper.wrapAssets('icon_add1.png'),width: ScreenUtil().setWidth(28),height: ScreenUtil().setWidth(28)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Text('*依据用药情况，设置对该患者的随访时间，系统将自动给予患者发送用药随访单，并提醒医生随访。',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey)),
                SizedBox(height: ScreenUtil().setWidth(30))
              ],
            ),
          )
        ],
      )
    );
  }
}