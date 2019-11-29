import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/dialog_share.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context,'我的名片', actionText: '分享', onActionPress: () {
        showModalBottomSheet(
            context: context, builder: (context) => ShareDialog());
      }),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    ImageHelper.wrapAssets('bg_mingpian.png')))),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 2),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        width: 50,
                        height: 50,
                        imageUrl: userModel.user.icon??'',
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Image.asset(ImageHelper.wrapAssets('yishengtouxiang.png'), width: 50, height: 50),
                      ),
                    )
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userModel.user.name ,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${userModel.user.type} | ${userModel.user.level}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    )
                  ),
                ],
              )
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20,10,20,10),
              decoration: BoxDecoration(
                color: Color(0xfffcf3e4),
                borderRadius: BorderRadius.circular(5)),
              child: Text('公告：找',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12)),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '擅长领域',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1,color: Colors.grey[400])
                    ),
                    child: Text(userModel.user.type),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal:10),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '个人简介',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(10),
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1,color: Colors.grey[400])
                    ),
                    child: Text(
                      '我是职业中医师，您有什么日常身体疾病需要帮助，可以给我图文留言或者电话咨询!',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () => print('编辑名片'),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '编辑名片',
                            style: TextStyle(color: Colors.white),
                          )),
                      ))
                  ],
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
