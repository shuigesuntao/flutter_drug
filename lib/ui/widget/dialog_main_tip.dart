
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTipDialog extends Dialog{
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child:  Center(
        child: Container(
          height: ScreenUtil().setWidth(390),
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(15),ScreenUtil().setWidth(20),ScreenUtil().setWidth(15)),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: <Widget>[
              Text('温馨提示',style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(16))),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
                  child:ListView(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: '        欢迎使用药匣子APP！在您使用时，需要连接数据网络或者WLAN网络，'
                            '产生的流量费用请咨询当地运营商。药匣子公司非常重视您的隐私保护和个人信息保护。在您使用药匣子APP服务前，请认真阅读',
                          style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.black),
                          children: [
                            TextSpan(
                              text: '《药匣子服务协议》',
                              style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor),
                            ),
                            TextSpan(
                              text: '及',
                              style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.black),
                            ),
                            TextSpan(
                              text: '《免责条款》',
                              style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor),
                            ),
                            TextSpan(
                              text: '全部内容。您同意并接受全部条款后再开始使用我们的服务',
                              style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.black),
                            ),
                          ]
                        )
                      ),
                      Text('        在您使用药匣子App时，我们可能会需要用到一下信息，您可以在设备系统“设置”里进行相关权限信息管理。',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.black)),
                      Text('        如您需要修改个人头像信息、上传医师执业资格认证、上传患者病历图片、上传图片处方等服务，我们会申请使用您的摄像头（相机）权限、相册权限。'
                        '如您需要联系平台客服电话等服务，我们会申请读取您的电话状态（获取设备IMSI、IMEI号）、及直接拨打电话权限。如您需要添加、关联患者通讯录等信息服务，'
                        '我们会将此信息保存至您的手机本地存储，我们将申请写入外置存储器权限、读取外置存储器权限。如您需要向患者发送语音等服务，我么将申请获取您的录音权限。',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.black))
                    ],
                  ),
              )),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return SecondTipDialog();
                          });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setWidth(35),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Colors.grey[400],width: 1)
                        ),
                        child: Text('不同意',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      ),
                    )
                  ),
                  SizedBox(width: ScreenUtil().setWidth(5)),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                        StorageManager.sharedPreferences
                          .setBool('firstOpen', false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setWidth(35),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Theme.of(context).primaryColor,width: 1)
                        ),
                        child: Text('同意并继续',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(14))),
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



class SecondTipDialog extends Dialog{
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child:  Center(
        child: Container(
          height: ScreenUtil().setWidth(154),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height:  ScreenUtil().setWidth(15)),
              Text('温馨提示',style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(16))),
              Padding(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(20),ScreenUtil().setWidth(15),ScreenUtil().setWidth(25)),
                child: Text('请同意并接受《药匣子服务协议》及《免责条款》全部条款后再开始使用我们的服务',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)))
              ),
              Divider(height: 0.5,color: Colors.grey[400]),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return MainTipDialog();
                    });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
                  child: Text('下一步',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}