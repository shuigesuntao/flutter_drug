import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/diagnosis.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/user_title_bar.dart';
import 'package:flutter_drug/view_model/diagnosis_record_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FriendInfoPage extends StatelessWidget {
  final Friend friend;

  FriendInfoPage({this.friend});

  final List<String> groups = ['全部', '新建分组'];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: UserTitleBar('患者档案',actionText: '分组',onActionPressed: (){
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => _buildGroupItem(groups[index]),
              separatorBuilder: (BuildContext context, int index) => Divider(height: 1,color: Colors.grey,),
              itemCount: groups.length);
          });
      },),
      body: Column(
        children: <Widget>[
          Expanded(child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ProviderWidget<DiagnosisRecordModel>(
              model: DiagnosisRecordModel(),
              onModelReady: (model)=>model.initData(),
              builder: (context,model,child){
                return SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: !model.empty ,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Column(
                          children: <Widget>[
                            _buildFriendInfoHeader(),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(15,15,0,15),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('既往病史'),
                                      SizedBox(width: 15),
                                      Text('脑梗塞,',style: TextStyle(fontSize: 13))
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 15),child: Divider(height: 1,color: Colors.grey)),
                                  Row(
                                    children: <Widget>[
                                      Text('过敏病史'),
                                      SizedBox(width: 15),
                                      Text('中药,',style: TextStyle(fontSize: 13))
                                    ],
                                  )
                                ],
                              )
                            ),
                            SizedBox(height: 10),
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(child: Text('完善病历')),
                                        GestureDetector(
                                          onTap: () =>  showToast('提醒成功!'),
                                          child: Text('提醒患者完善病历',style: TextStyle(color: Colors.red[900])),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(indent: 15,height: 1,color: Colors.grey),
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlineButton(
                                        padding: EdgeInsets.all(10),
                                        onPressed: () => print('完善病历'),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.add,size: 20,color: Theme.of(context).primaryColor),
                                            Text(
                                              '帮助患者完善病历',
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                            )
                                          ],
                                        ),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(1))),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.white,
                              padding: EdgeInsets.all(15),
                              child: Text('病历档案'),
                            )
                          ],
                        ),
                      ),
                      model.busy
                        ? SliverToBoxAdapter(child: Container(height:400,alignment:Alignment.center,child: CircularProgressIndicator()))
                        : model.error
                        ? ViewStateWidget(onPressed: model.initData)
                        : model.empty
                        ? ViewStateEmptyWidget()
                        : SliverList(delegate:
                      SliverChildBuilderDelegate(
                          (context,index) => _buildDiagnosisRecordItem(context,model.list[index],model.list.length - index)
                        ,childCount: model.list.length)
                      )
                    ],
                  )
                );
              },
            ),
          )),
          SafeArea(
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Expanded(child: SizedBox(
                    child: FlatButton(
                      onPressed: ()=>print('进入会话'),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        '进入会话',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  )),
                  SizedBox(width: 10),
                  Expanded(child: SizedBox(
                    child: FlatButton(
                      onPressed: ()=> Navigator.of(context).pushNamed(
                        RouteName.openPrescription,
                        arguments: friend
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        '在线开方',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ))
                ],
              )
            ),
            bottom: true,
          )
        ],
      )
    );
  }

  Widget _buildGroupItem(String group) {
    return GestureDetector(
      onTap: () => print(group),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: Text(group, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildFriendInfoHeader() {
    return Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(ImageHelper.wrapAssets('bg_mingpian.png')))),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: friend.headerUrl,
                errorWidget: (context, url, error) => friend.gender == "女"
                    ? Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
                        width: 55, height: 55)
                    : Image.asset(ImageHelper.wrapAssets('gender_boy.png'),
                        width: 55, height: 55),
                fit: BoxFit.fill,
                width: 55,
                height: 55,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        friend.displayName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => print('点击了编辑'),
                        child: Image.asset(ImageHelper.wrapAssets('ic_edit.png'), width: 20, height: 20),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text('真实姓名 ${friend.name}',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Text(
                    "${_getGender(friend.gender)}${friend.age}岁 | ${friend.phone}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
            )
            )
          ],
        )
    );
  }

  _getGender(String gender) {
    String genderStr = '';
    if (gender != null && gender.isNotEmpty) {
      genderStr = '$gender | ';
    }
    return genderStr;
  }


  Widget _buildDiagnosisRecordItem(BuildContext context ,Diagnosis diagnosis,int no) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1
                    )
                  ),
                  child: Text(no.toString(),style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
                SizedBox(width: 10),
                Expanded(child: Text('诊断记录')),
                Text(diagnosis.time,style: TextStyle(color: Colors.grey))
              ],
            )
          ),
          Divider(color: Colors.grey,height: 1),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('【诊断】'),
                    SizedBox(width: 5),
                    Expanded(child: Text(diagnosis.diagnosis),)
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('【治疗】'),
                    SizedBox(width: 5),
                    Expanded(child: Text(_getDrugsText(diagnosis.drugs),maxLines: 2))
                  ],
                )
              ],
            )
          ),
          Divider(color: Colors.grey,height: 1),
          GestureDetector(
            onTap: () => print('查看详情'),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('查看详情',style: TextStyle(fontSize: 15,color: Colors.grey)),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[300],
                  ),
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  String _getDrugsText(List<Drug> drugs){
    String text = '';
    if(drugs.length > 6){
      text = drugs.sublist(0,6).map((drug) => '${drug.name}${drug.count}${drug.unit}').toList().join('  ') + '  ...';
    }else{
      text = drugs.map((drug) => '${drug.name}${drug.count}${drug.unit}').toList().join('  ');
    }
    return text;
  }
}
