import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/publish_notice_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class PublishNoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PublishNoticePageState();
}

class _PublishNoticePageState extends State<PublishNoticePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '发布公告', actionText: '发布',
          onActionPress: () {
        String text = _controller.value.text;
        if (text.isEmpty) {
          showToast('请添加公告内容', radius: 5);
        } else {
          print('点击了发布$text');
        }
      }),
      body: GestureDetector(
        //点击空白关闭键盘
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ProviderWidget<PublishNoticeModel>(
          model: PublishNoticeModel(),
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Divider(height: 1, color: Colors.grey),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        _buildNoticeInput(),
                        _buildSwitch(),
                        Image.asset(ImageHelper.wrapAssets('yzline.png')), //虚线
                        _buildValidity()
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildNotice()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNoticeInput() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(5),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            //去掉输入框的下滑线
            fillColor: Color(0xFFF7F7F7),
            contentPadding: EdgeInsets.all(5),
            filled: true,
            hintText: "您的患者可在微信公众号【药匣子在线】查看您发布的公告内容。",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            enabledBorder: null,
            disabledBorder: null),
        controller: _controller,
        maxLength: 300,
        maxLines: 6,
      ),
    );
  }

  Widget _buildSwitch() {
    return Consumer<PublishNoticeModel>(builder: (context, model, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('同时发送公众号消息'),
            ),
            Text(model.isPublishWeChat ? '是' : '否',
              style: TextStyle(
                color: model.isPublishWeChat
                  ? Theme.of(context).primaryColor
                  : Colors.black87)),
            CupertinoSwitch(
              activeColor: Theme.of(context).primaryColor,
              value: model.isPublishWeChat,
              onChanged: (value) {
                model.isPublishWeChat = value;
              },
            )
          ],
        ),
      );
    });
  }

  Widget _buildValidity() {
    return InkWell(
      onTap: () => print('选择公告有效期'),
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('公告有效期')),
                Consumer<PublishNoticeModel>(builder: (_,model,__) => Text(model.validity)),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '有效期结束后会自动撤下公告',
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNotice() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('当前公告',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                  width: 60,
                  height: 25,
                  child: OutlineButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return DialogAlert(
                          content: '是否撤下当前公告？',
                          onPressed: () {
                            print('撤下公告');
                            Navigator.pop(context);
                          },
                        );
                      }),
                    color: Colors.white,
                    child: Text('撤下'),
                    borderSide: BorderSide(color: Colors.black54, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  ),
                ),
              ],
            )),
          Divider(height: 1, color: Colors.grey),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('来开方'),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '发布于:2019-09-03 20:58:54',
                        style: TextStyle(color: Colors.grey),
                      )),
                    Text('永久有效', style: TextStyle(color: Colors.grey))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
