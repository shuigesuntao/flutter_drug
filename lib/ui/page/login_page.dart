import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/user.dart';
import 'package:flutter_drug/ui/widget/dialog_loading.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart' as P;

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  bool isVerify = true;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _verifyCodeController = TextEditingController();

  //定义变量
  Timer _timer;

  //倒计时数值
  var countdownTime = -1;

  //倒计时方法
  void startCountdown() {
    countdownTime = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(this.mounted){
        setState(() {
          if (countdownTime < 1) {
            _timer.cancel();
          } else {
            countdownTime -= 1;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: TitleBar.buildCommonAppBar(context, ''),
        body: Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('登录药良心',style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.bold)),
              SizedBox(height: ScreenUtil().setWidth(20)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: ScreenUtil().setWidth(40),
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d+'))
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            hintText: '请输入手机号',
                            hintStyle: TextStyle(color: Colors.grey,
                              fontSize: ScreenUtil().setSp(14)),
                            counterText:''),
                          controller: _phoneController,
                          maxLines: 1,
                          maxLength: 11,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                        ),
                      ),
                    )
                  ),
                  Offstage(
                    offstage: !isVerify,
                    child: GestureDetector(
                      onTap: () {
                        if (countdownTime == 0) {
                          startCountdown();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8), ScreenUtil().setWidth(2), ScreenUtil().setWidth(8), ScreenUtil().setWidth(2)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: countdownTime>0?Colors.grey:Theme
                            .of(context)
                            .primaryColor, width: 1)
                        ),
                        child: Text(countdownTime > 0
                          ? '${countdownTime}s后重发'
                          : countdownTime==0? '重新获取':'获取验证码', style: TextStyle(color:countdownTime>0?Colors.grey: Theme
                          .of(context)
                          .primaryColor, fontSize: ScreenUtil().setSp(13))),
                      ),
                    ),
                  )
                ],
              ),
              Divider(height: 0.5, color: Colors.grey[400]),
              SizedBox(height: ScreenUtil().setWidth(5)),
              Offstage(
                offstage: !isVerify,
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil().setWidth(40),
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: '请输入验证码',
                        hintStyle: TextStyle(color: Colors.grey,
                          fontSize: ScreenUtil().setSp(14)),
                        counterText:''),
                      controller: _verifyCodeController,
                      maxLines: 1,
                      maxLength: 6,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                    ),
                  ),
                )
              ),
              Offstage(
                offstage: isVerify,
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil().setWidth(40),
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: '请输入密码',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(14))
                      ),
                      controller: _passwordController,
                      maxLines: 1,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                    ),
                  ),
                )
              ),
              Divider(height: 0.5, color: Colors.grey[400]),
              SizedBox(height: ScreenUtil().setWidth(20)),
              GestureDetector(
                onTap: (){
                  if(_phoneController.text.isEmpty){
                    showToast('请输入手机号');
                  }else if (_phoneController.text.length < 11){
                    showToast('请输入正确的手机号');
                  }else if(_verifyCodeController.text.isEmpty && isVerify){
                    showToast('请输入验证码');
                  } else if(_verifyCodeController.text.length < 6 && isVerify){
                    showToast('请输入正确的验证码');
                  } else if(_passwordController.text.isEmpty  && !isVerify){
                    showToast('请输入密码');
                  }else{
                    showDialog(context: context,builder:(context){
                      return LoadingDialog(text:'登录中...');
                    });
                    Future.delayed(Duration(seconds: 2), (){
                      Navigator.of(context).pop();
                      P.Provider.of<UserModel>(context,listen: false).saveUser(User(1,"http://img2.woyaogexing.com/2019/08/30/3c02345e50aa4fbbadce736ae72d9313!600x600.jpeg","薛Tony","内科","主任医师"));
                      Navigator.of(context).pushNamed(RouteName.tab);
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil().setWidth(40),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    color: Theme
                      .of(context)
                      .primaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(
                    '同意协议并登录',
                    style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(15)),
                  )
                ),
              ),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isVerify = !isVerify;
                      });
                    },
                    child: Text(isVerify?'账号密码登录':'手机快捷登录',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey)),
                  ),
                  Offstage(
                    offstage: isVerify,
                    child:GestureDetector(
                      onTap: (){},
                      child: Text('忘记密码?',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey)),
                    ),
                  )
                ],
              ),
              Expanded(child: SizedBox()),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: Divider(height: 1,color: Colors.grey[400])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                          child: Text('第三方登录',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey))
                        ),
                        Expanded(child: Divider(height: 1,color: Colors.grey[400]))
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setWidth(15)),
                    Image.asset(ImageHelper.wrapAssets('icon_weixin.png'),width: ScreenUtil().setWidth(42),height: ScreenUtil().setWidth(42)),
                    SizedBox(height: ScreenUtil().setWidth(30)),
                    Column(
                      children: <Widget>[
                        Text('为保障您的个人隐私权益，请在点击同意按钮前认真阅读' ,style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('下方协议：',style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                            Text('《药良心服务协议》',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor)),
                            Text('、',style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                            Text('《免责条款》',style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Theme.of(context).primaryColor)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                bottom: true
              ),
            ],
          ),
        )
      )
    );
  }


  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
}