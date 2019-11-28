import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/image_button.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:oktoast/oktoast.dart';

class WeChatCashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeChatCashPageState();
}

class WeChatCashPageState extends State<WeChatCashPage> {
  TextEditingController _controller = TextEditingController();
  double account = 5.01;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '微信提现'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:
                        Text('提现到微信钱包 | 已绑定', style: TextStyle(fontSize: 15)),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(RouteName.bindWeChat),
                    child: Text('更换',
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('提现金额', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text('￥',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      Expanded(
                          child: TextField(
                        autofocus: true,
                        cursorColor: Theme.of(context).primaryColor,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp(r"^[.0-9]+$"))
                        ],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            enabledBorder: null,
                            disabledBorder: null),
                        controller: _controller,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 50),
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: SimpleImageButton(
                            normalImage: ImageHelper.wrapAssets(
                                'search_clear_normal.png'),
                            pressedImage: ImageHelper.wrapAssets(
                                'search_clear_pressed.png'),
                            width: 20,
                            onPressed: () {
                              _controller.clear();
                            }),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.text = account.toString();
                        },
                        child: Text('全部',
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor)),
                      )
                    ],
                  ),
                  Divider(height: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('钱包余额￥$account', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('温馨提示', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 10),
                  Text('1.钱包余额大于50元，可申请提现',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 5),
                  Text('2.单次最大可申请5000元，每天最多申请5次；',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 5),
                  Text('3.累计提现金额大于5000元，本平台将代扣0.6%手续费给予第三方支付平台。',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: SafeArea(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xffeaaf4c),
                              borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '免手续费提现',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            if (_controller.text.isNotEmpty &&
                              double.parse(_controller.text) > account) {
                              showToast('提现金额大于账户可提现金额');
                            } else if (_controller.text.isEmpty ||
                              double.parse(_controller.text) < 50) {
                              showToast('提现金额不能小于50');
                            }
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '提现',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                        )
                      ],
                    ),
                  ),
                  bottom: true
              ),
            )
          ],
        ),
      ),
    );
  }
}
