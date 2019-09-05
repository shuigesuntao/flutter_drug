import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/service_setting_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ServiceSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServiceSettingPageState();
}

class _ServiceSettingPageState extends State<ServiceSettingPage> {
  final _afterAskController = TextEditingController(text: ServiceSettingModel().afterAskPrice.toString());
  final _onlineAskController =
  TextEditingController(text: ServiceSettingModel().onlineAskPrice.toString());
  final _singlePriceController =
  TextEditingController(text: ServiceSettingModel().singleServicePrice.toString());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '服务设置'),
      body: GestureDetector(
        //点击空白关闭键盘
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: ProviderWidget<ServiceSettingModel>(
            model: ServiceSettingModel(),
            builder: (context, model, child) {
              return Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '线上咨询',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    _buildAskPriceInput(context, _onlineAskController,
                      '线上咨询费', '*医生手动结束问诊后，收益立即发送到医生钱包'),
                    _buildAskPriceInput(context, _afterAskController, '后续咨询费',
                      '*建议为老患者提供适当的优惠'),
                    _buildServiceDesc(),
                    _buildSwitch(),
                    Image.asset(ImageHelper.wrapAssets('yzline.png')), //虚线
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        '在线开方',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    _buildSinglePrice(context, _singlePriceController)
                  ],
                ),
              );
            })
        )
      ),
    );
  }

  Widget _buildAskPriceInput(BuildContext context,
      TextEditingController controller, String title, String desc) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFDDFAF8), borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 15))),
                SizedBox(
                  width: 50,
                  child: TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    //只允许输入数字
                    decoration: InputDecoration(
                      //去掉输入框的下滑线
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(right: 5),
                    ),
                    controller: controller,
                    onChanged: (text) {
                      if (text.isEmpty) {
                        controller.text = '0';
                      } else if (text.startsWith('0')) {
                        controller.text = text.substring(1);
                      } else if (int.parse(text) > 2000) {
                        showToast('最大可设置2000');
                        controller.text = '2000';
                      } else {
                        controller.text = text;
                      }
                    },
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    //输入文本的样式
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                Text('元/次', style: TextStyle(color: primaryColor)),
                Icon(
                  Icons.chevron_right,
                  color: primaryColor,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(desc,
                  style: TextStyle(color: primaryColor, fontSize: 13)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDesc() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300], width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Color(0xFFDDFAF8),
              child: Text(
                '服务说明',
                style: TextStyle(fontSize: 13),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child:
                Text('1、服务期间您可以使用图文、语音与患者交流；', style: TextStyle(fontSize: 13)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('2、首次回复时间需在24小时内，单次服务时间为首次回复后的72小时，若确认已解决患者问题，可提前结束对话；',
                style: TextStyle(fontSize: 13)),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child:
                Text('3、逾期未回复患者，平台将自动结束该项问诊；', style: TextStyle(fontSize: 13)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text('4、您需根据患者实际情况辩证开方、给出调理建议；',
                style: TextStyle(fontSize: 13)),
          )
        ],
      ),
    );
  }

  Widget _buildSwitch() {
    return Consumer<ServiceSettingModel>(builder: (context, model, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '是否开启咨询',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Text(model.isOpenAsk ? '开' : '关',
                style: TextStyle(
                    color: model.isOpenAsk
                        ? Theme.of(context).primaryColor
                        : Colors.black54)),
            CupertinoSwitch(
              activeColor: Theme.of(context).primaryColor,
              value: model.isOpenAsk,
              onChanged: (value) {
                model.isOpenAsk = value;
              },
            )
          ],
        ),
      );
    });
  }

  Widget _buildSinglePrice(
      BuildContext context, TextEditingController controller) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
          color: Color(0xFFDDFAF8), borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text('单次处方服务费',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor))),
              SizedBox(
                width: 30,
                child: TextField(
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  //只允许输入数字
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    //去掉输入框的下滑线
                  ),
                  controller: controller,
                  textAlign: TextAlign.right,
                  keyboardType:  TextInputType.number,
                  textInputAction: TextInputAction.go,
                  //输入文本的样式
                  style: TextStyle(color: primaryColor),
                  onChanged: (text) {
                    if (text.isEmpty) {
                      controller.text = '0';
                    } else if (text.startsWith('0')) {
                      controller.text = text.substring(1);
                    } else if (int.parse(text) > 100) {
                      showToast('最大可设置100%');
                      controller.text = '100';
                    } else {
                      controller.text = text;
                    }
                  },
                ),
              ),
              Text('%', style: TextStyle(color: primaryColor)),
              Icon(
                Icons.chevron_right,
                color: primaryColor,
              ),
            ],
          ),
          Text('*最高可输入药费的100%；', style: TextStyle(color: primaryColor)),
          Text('*在患者支付时与药费合并显示；', style: TextStyle(color: primaryColor)),
          Text('*在线开方时系统会默认成您设置的比例；', style: TextStyle(color: primaryColor))
        ],
      ),
    );
  }
}
