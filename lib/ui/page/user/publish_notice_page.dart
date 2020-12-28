import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_alert.dart';
import 'package:flutter_drug/ui/widget/dialog_progress.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/publish_notice_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart' as P;

class PublishNoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PublishNoticePageState();
}

class _PublishNoticePageState extends State<PublishNoticePage> {
  final _controller = TextEditingController();

  bool cancel = false;
  String publish = '呵呵';
  String _day = '永久';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '发布公告', actionText: '发布',
          onActionPress: () {
        String text = _controller.text;
        if (text.isEmpty) {
          showToast('请添加公告内容');
        } else {
          if (cancel) {
            _publishNotice();
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogAlert(
                      content: '是否确定发布当前公告内容？确定\n则发布并覆盖上一条公告',
                      onPressed: () => _publishNotice());
                });
          }
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
                    padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                    child: Column(
                      children: <Widget>[
                        _buildNoticeInput(),
                        _buildSwitch(),
                        Image.asset(ImageHelper.wrapAssets('xuxian.png')), //虚线
                        _buildValidity()
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(15)),
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
            hintText: "请填写公告内容，公告将在您的名片顶部显示。",
            hintStyle:
                TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(14)),
            counterStyle: TextStyle(fontSize: ScreenUtil().setSp(12))),
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
        controller: _controller,
        maxLength: 300,
        maxLines: 6,
      ),
    );
  }

  Widget _buildSwitch() {
    return P.Consumer<PublishNoticeModel>(builder: (context, model, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('同时发送公众号消息',
                  style: TextStyle(fontSize: ScreenUtil().setSp(15))),
            ),
            Text(model.isPublishWeChat ? '是' : '否',
                style: TextStyle(
                    color: model.isPublishWeChat
                        ? Theme.of(context).primaryColor
                        : Colors.black87)),
            GestureDetector(
              onTap: () => model.isPublishWeChat = !model.isPublishWeChat,
              child: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: model.isPublishWeChat,
                onChanged: (value) {
                  model.isPublishWeChat = value;
                },
              ),
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
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            P.Consumer<PublishNoticeModel>(
              builder: (_, model, __) => GestureDetector(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                          message: Text('请选择'),
                          cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Navigator.pop(context),
                              child: Text('取消')),
                          actions: _buildDateActions(model),
                        )),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text('公告有效期',
                            style:
                                TextStyle(fontSize: ScreenUtil().setSp(15)))),
                    Text(_day),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),
                        width: 7, height: 14)
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
              child: Text(
                '有效期结束后会自动撤下公告',
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDateActions(PublishNoticeModel model) {
    final List<String> days = [
      '永久',
      '7天',
      '30天',
      '90天',
    ];
    return days
        .map((day) => CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _day = day;
              });
              Navigator.of(context).pop();
            },
            child: Text(day)))
        .toList();
  }

  Widget _buildNotice() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('当前公告',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(15))),
                  Offstage(
                    offstage: cancel,
                    child: SizedBox(
                      width: ScreenUtil().setWidth(60),
                      height: ScreenUtil().setWidth(25),
                      child: OutlineButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return DialogAlert(
                                content: '是否撤下当前公告？',
                                onPressed: () {
                                  setState(() {
                                    cancel = true;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }),
                        color: Colors.white,
                        child: Text('撤下',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: ScreenUtil().setSp(14))),
                        borderSide: BorderSide(color: Colors.black54, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                    ),
                  ),
                ],
              )),
          Divider(height: 1, color: Colors.grey),
          P.Consumer<PublishNoticeModel>(builder: (context, model, child) {
            return Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(publish,
                        style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                    SizedBox(height: ScreenUtil().setWidth(10)),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          '发布于:2019-09-03 20:58:54',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(12)),
                        )),
                        Text(
                            cancel
                                ? '已撤销'
                                : model.validity == '永久'
                                    ? '永久有效'
                                    : '有效期${model.validity}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(12)))
                      ],
                    )
                  ],
                ));
          })
        ],
      ),
    );
  }

  void _publishNotice() {
    Future.delayed(Duration(microseconds: 200), () {
      showDialog(
          context: context,
          builder: (context) {
            return ProgressDialog();
          });
      Future.delayed(Duration(seconds: 1), () {
        showToast('发布成功!');
        setState(() {
          publish = _controller.text;
          cancel = false;
        });
        _controller.text = '';
        Navigator.of(context).pop();
      });
    });
  }
}
