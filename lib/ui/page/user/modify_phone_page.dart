import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModifyPhonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifyPhonePageState();

}

class _ModifyPhonePageState extends State<ModifyPhonePage> {

  final String phone = '18322223519';

  TextEditingController _controller = TextEditingController();

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
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text('当前绑定的手机号为:${_getPhoneStr(phone)}',
                  style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                SizedBox(height: ScreenUtil().setWidth(15)),
                Divider(height: 0.5, color: Colors.grey[400]),
                SizedBox(height: ScreenUtil().setWidth(10)),
                Row(
                  children: <Widget>[
                    Image.asset(
                      ImageHelper.wrapAssets('yanzhengma.png'), width: ScreenUtil().setWidth(18),
                      height: ScreenUtil().setWidth(14)),
                    SizedBox(width: ScreenUtil().setWidth(10)),
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
                            fontSize: ScreenUtil().setSp(16)),
                          enabledBorder: null,
                          disabledBorder: null),
                        controller: _controller,
                        maxLines: 1,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        if (countdownTime == 0) {
                          startCountdown();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8), ScreenUtil().setWidth(2), ScreenUtil().setWidth(8), ScreenUtil().setWidth(2)),
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
                          .primaryColor, fontSize: ScreenUtil().setSp(16))),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setWidth(50)),
          GestureDetector(
            onTap: () => print('下一步'),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
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
                '下一步',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
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