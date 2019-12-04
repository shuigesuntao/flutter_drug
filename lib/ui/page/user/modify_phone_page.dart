import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

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
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text('当前绑定的手机号为:${_getPhoneStr(phone)}',
                  style: TextStyle(fontSize: 16)),
                SizedBox(height: 15),
                Divider(height: 1, color: Colors.grey),
                SizedBox(height: 10),
                Row(
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
                        controller: _controller,
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
                )
              ],
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () => print('下一步'),
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
                '下一步',
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