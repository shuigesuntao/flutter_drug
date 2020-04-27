import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_custom_input.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/service_setting_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ServiceSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServiceSettingPageState();
}

class _ServiceSettingPageState extends State<ServiceSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TitleBar.buildCommonAppBar(context, '服务设置'),
      body: GestureDetector(
          //点击空白关闭键盘
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ProviderWidget<ServiceSettingModel>(
              model: ServiceSettingModel(),
              builder: (context, model, child) {
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(15)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                                width: 4,
                                height: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                '线上咨询',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(15)),
                              )
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setWidth(5)),
                          _buildAskSwitch(),
                          Divider(height: 0.5, color: Colors.grey[400]),
                          _buildAskPrice(
                            '线上咨询费',
                            '结束后收益立即到账',
                            model.onlineAskPrice,
                            onPressed: () => showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomInputDialog(
                                      title: '设置线上咨询费',
                                      hint: '0',
                                      maxValue: 2000,
                                      keyboardType: TextInputType.number,
                                      content: model.onlineAskPrice == 0
                                          ? ''
                                          : model.onlineAskPrice.toString(),
                                      onPressed: (text) {
                                        if (text.isEmpty) {
                                          model.onlineAskPrice = 0;
                                        } else {
                                          showToast('修改成功');
                                          model.onlineAskPrice = int.parse(text);
                                        }
                                      });
                                }),
                          ),
                          Divider(height: 0.5, color: Colors.grey[400]),
                          _buildAskPrice(
                            '后续咨询费',
                            '建议为老患者提供优惠',
                            model.afterAskPrice,
                            onPressed: () => showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomInputDialog(
                                      title: '设置后续咨询费',
                                      hint: '0',
                                      maxValue: 2000,
                                      keyboardType: TextInputType.number,
                                      content: model.afterAskPrice == 0
                                          ? ''
                                          : model.afterAskPrice.toString(),
                                      onPressed: (text) {
                                        if (text.isEmpty) {
                                          model.afterAskPrice = 0;
                                        } else {
                                          showToast('修改成功');
                                          model.afterAskPrice = int.parse(text);
                                        }
                                      });
                                }),
                          ),
                          Divider(height: 0.5, color: Colors.grey[400]),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                              child: Text('服务说明',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                          Text('1、服务期间您可以使用图文、语音与患者交流;',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12), color: Colors.grey[600])),
                          RichText(
                              text: TextSpan(
                                  text: '2、',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '首次',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '回复时间需在',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12), color: Colors.grey[600])),
                                TextSpan(
                                    text: '24小时内',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        '，单次服务时间为首次回复后的72小时，若确认已解决患者问题，可提前结束对话;',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]))
                              ])),
                          Text('3、逾期未回复患者，平台将自动结束该项问诊;',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12), color: Colors.grey[600])),
                          Text('4、您需根据患者实际情况辩证开方、给出调理建议；',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12), color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(15)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                                width: 4,
                                height: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                '在线开方',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(15)),
                              )
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setWidth(10)),
                          _buildPriceSwitch(),
                          Divider(height: 0.5, color: Colors.grey[400]),
                          GestureDetector(
                            onTap: () => showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomInputDialog(
                                      title: '设置单次处方服务费',
                                      keyboardType: TextInputType.number,
                                      hint: '0',
                                      maxValue: 100,
                                      content: model.singleServicePrice == 0
                                          ? ''
                                          : model.singleServicePrice.toString(),
                                      onPressed: (text) {
                                        if (text.isEmpty) {
                                          model.singleServicePrice = 0;
                                        } else if(int.parse(text) > 2000){
                                          showToast('最大可设置2000');
                                        }else{
                                          showToast('修改成功');
                                          model.singleServicePrice = int.parse(text);
                                        }
                                      });
                                }),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('单次处方服务费'),
                                    ),
                                    Text('${model.singleServicePrice}%',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: ScreenUtil().setSp(13))),
                                    Icon(
                                      CupertinoIcons.right_chevron,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                )),
                          ),
                          Divider(height: 0.5, color: Colors.grey[400]),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                              child: Text('设置说明',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                          RichText(
                              text: TextSpan(
                                  text: '1、',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '最高',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: '可输入药费的',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12), color: Colors.grey[600])),
                                TextSpan(
                                    text: '100%',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: ';',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]))
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: '2、在患者支付时',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '与药费合并显示',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: ';',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]))
                              ])),
                          Text('3、在线开方时系统会默认成您设置的比例；',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12), color: Colors.grey[600]))
                        ],
                      ),
                    )
                  ],
                );
              })
      ),
    );
  }

  Widget _buildAskPrice(String title, String desc, int price,
      {VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(title),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Text(desc,
                        style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(13))),
                  ],
                ),
              ),
              Text('$price 元/次',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(13))),
              Icon(
                CupertinoIcons.right_chevron,
                size: 20,
                color: Colors.grey[600],
              ),
            ],
          )),
    );
  }

  Widget _buildAskSwitch() {
    return Consumer<ServiceSettingModel>(builder: (context, model, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Expanded(child: Text('是否开启咨询',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
            Text(model.isOpenAsk ? '开' : '关',
                style: TextStyle(
                    color: model.isOpenAsk
                        ? Theme.of(context).primaryColor
                        : Colors.black54,
                  fontSize: ScreenUtil().setSp(14))),
            GestureDetector(
              onTap: () => model.isOpenAsk = !model.isOpenAsk,
              child:  CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: model.isOpenAsk,
                onChanged: (value) {
                  model.isOpenAsk = value;
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildPriceSwitch() {
    return Consumer<ServiceSettingModel>(builder: (context, model, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Expanded(child: Text('是否隐藏诊费',style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
            Text(model.isHidePrice ? '隐藏' : '不隐藏',
              style: TextStyle(
                color: model.isHidePrice
                  ? Theme.of(context).primaryColor
                  : Colors.black54,
                fontSize: ScreenUtil().setSp(14))),
            GestureDetector(
              onTap: () => model.isHidePrice = !model.isHidePrice,
              child:  CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: model.isHidePrice,
                onChanged: (value) {
                  model.isHidePrice = value;
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
