import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/utils/platform_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AboutPageState();

}

class AboutPageState extends State<AboutPage>{
  String _version;
  String _appName;

  @override
  void initState() {
    super.initState();
    getAppName();
    getAppVersion();
  }
  @override
  Widget build(BuildContext context) {
    final String phone = '400-520-120';
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '关于药匣子'),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Image.asset(ImageHelper.wrapAssets('logo.png'),width: 100,height: 100),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('药匣子 V$_version',style: TextStyle(fontSize: 16,color: Colors.grey))
          ),
          GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(phone),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text("取消"),
                        onPressed: () {
                          Navigator.maybePop(context);
                          print("取消");
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("呼叫"),
                        onPressed: ()=> callPhone(phone),
                      ),
                    ],
                  );
                });
            },
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('联系客服',style: TextStyle(fontSize: 18))),
                  Text(phone,style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor))
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              bottom: true,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('北京一药良心信息科技有限公司'),
                  SizedBox(height: 3),
                  Text('©2017-2019 药匣子 technology co.,ltd')
                ],
              ),
            )
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  void callPhone(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  getAppName() async{
    _appName = await PlatformUtils.getAppName();

  }
  getAppVersion() async{
    _version = await PlatformUtils.getAppVersion();
  }

}