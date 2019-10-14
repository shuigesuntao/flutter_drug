import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/dialog_share.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.buildCommonAppBar(
        context,
        '二维码名片',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: userModel.user.icon,
                fit: BoxFit.fill,
                width: 70,
                height: 70,
              ),
            ),
          ),
          Text(
            userModel.user.name,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          ),
          Text(
            userModel.user.level,
            style: TextStyle(fontSize: 14,color: Colors.grey),
          ),
          SizedBox(height: 30),
          Text(
            '随时随地找我',
            style: TextStyle(fontSize: 18,letterSpacing: 1.3),
          ),
          Text(
            '复诊调方',
            style: TextStyle(fontWeight:FontWeight.bold,fontSize: 28,letterSpacing: 2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: QrImage(
              data: userModel.user.id.toString(),
              version: QrVersions.auto,
              size: 150.0,
            ),
          ),
          Text(
            '微信扫描上方我的二维码',
          ),
          Text(
            '完成个人信息填写',
          ),
          Text(
            '即可随时随地找我复诊调方',
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20,0,20,40),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        onPressed: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ShareDialog()
                          );
                        },
                        color: Theme
                            .of(context)
                            .primaryColor,
                        child: Text(
                          '立即分享',
                          style: TextStyle(color: Colors.white,fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
