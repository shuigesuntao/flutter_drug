import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:oktoast/oktoast.dart';

class ModifyPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifyPasswordPageState();

}

class _ModifyPasswordPageState extends State<ModifyPasswordPage> {

  final String phone = '18322223519';

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
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
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '修改绑定手机'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10,20,10,20),
            child: Text('您的登录手机号为:${_getPhoneStr(phone)}',
              style: TextStyle(fontSize: 16))
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10,12,10,12),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        ImageHelper.wrapAssets('password.png'), width: 14,
                        height: 16),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          obscureText:true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            hintText: '请输入6-16位新密码',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16)
                          ),
                          controller: _newPasswordController,
                          maxLines: 1,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(fontSize: 16),
                        )
                      )
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Padding(
                  padding: EdgeInsets.fromLTRB(10,12,10,12),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        ImageHelper.wrapAssets('password.png'), width: 14,
                        height: 16),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          obscureText:true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            hintText: '请再次输入新密码',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16)
                          ),
                          controller: _confirmPasswordController,
                          maxLines: 1,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(fontSize: 16),
                        )
                      )
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        ImageHelper.wrapAssets('yanzhengma.png'), width: 18,
                        height: 14),
                      SizedBox(width: 10),
                      Expanded(
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
                              fontSize: 16),
                            enabledBorder: null,
                            disabledBorder: null),
                          controller: _verifyCodeController,
                          maxLines: 1,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(fontSize: 16),
                        )
                      ),
                      GestureDetector(
                        onTap: () {
                          if (countdownTime == 0) {
                            startCountdown();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: countdownTime>0?Colors.grey:Theme
                              .of(context)
                              .primaryColor, width: 1)
                          ),
                          child: Text(countdownTime > 0
                            ? '${countdownTime}s后重发'
                            : countdownTime==0? '重新获取':'获取验证码', style: TextStyle(color:countdownTime>0?Colors.grey: Theme
                            .of(context)
                            .primaryColor, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: (){
              if(_newPasswordController.text.length < 6
                ||  _newPasswordController.text.length > 16
                || _confirmPasswordController.text.length < 6
                || _confirmPasswordController.text.length > 16){
                showToast('密码长度不正确');
              }else if (_newPasswordController.text != _confirmPasswordController.text){
                showToast('两次输入的新密码不一致');
              }else if(_verifyCodeController.text.isEmpty){
                showToast('验证码不能为空');
              } else if(_verifyCodeController.text.length < 6){
                showToast('验证码长度不正确');
              }else{
               print('更换');
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme
                  .of(context)
                  .primaryColor,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                '更换',
                style: TextStyle(color: Colors.white),
              )
            ),
          ),
        ],
      )
    );
  }

  String _getPhoneStr(String phone) {
    return phone.replaceFirst(new RegExp(r'\d{4}'), '****', 3);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
}