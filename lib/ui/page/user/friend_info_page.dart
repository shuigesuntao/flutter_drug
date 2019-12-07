import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/diagnosis.dart';
import 'package:flutter_drug/model/drug.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_friend_name_input.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/diagnosis_record_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FriendInfoPage extends StatefulWidget {
  final Friend friend;

  FriendInfoPage({this.friend});

  @override
  State<StatefulWidget> createState() => FriendInfoPageState();

}

class FriendInfoPageState extends State<FriendInfoPage>{
  String _displayName;
  final List<String> groups = ['全部', '+新建分组'];
  @override
  void initState() {
    super.initState();
    _displayName = widget.friend.displayName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context,'患者档案',titleColor:Colors.white,backColor:Colors.white,backgroundColor:Color(0xffe56068),
        actionText: '分组',actionTextColor:Colors.white,onActionPress: (){
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => _buildGroupItem(groups[index],index == groups.length-1),
              itemCount: groups.length);
          });
      },
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Container(
            child: ProviderWidget<DiagnosisRecordModel>(
              model: DiagnosisRecordModel(),
              onModelReady: (model)=>model.initData(),
              builder: (context,model,child){
                return SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true ,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Column(
                          children: <Widget>[
                            Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    _buildFriendInfoHeader(context),
                                    Container(
                                      color: Colors.white,
                                      height: ScreenUtil().setWidth(80),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                                  decoration: BoxDecoration(
                                    color:  Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey[400],width: 0.5)
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(10)),child: Row(
                                        children: <Widget>[
                                          Text('既往病史'),
                                          SizedBox(width: ScreenUtil().setWidth(15)),
                                          Text('脑梗塞,',style: TextStyle(fontSize: ScreenUtil().setSp(13)))
                                        ],
                                      )),
                                      Divider(height: 0.5,color: Colors.grey[400]),
                                      Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(10)),child: Row(
                                        children: <Widget>[
                                          Text('过敏病史'),
                                          SizedBox(width: ScreenUtil().setWidth(15)),
                                          Text('患者暂未填写',style: TextStyle(fontSize: ScreenUtil().setSp(13),color: Colors.grey))
                                        ],
                                      ),)
                                    ],
                                  )
                                ),
                              ],
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
                                        Expanded(child: Text('完善病历',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(14)))),
                                        GestureDetector(
                                          onTap: () =>  showToast('提醒成功!'),
                                          child: Text('提醒患者完善病历',style: TextStyle(color: Color(0xffeaaf4c),fontSize: ScreenUtil().setSp(14))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(indent: ScreenUtil().setWidth(15),height: 1,color: Colors.grey),
                                  Padding(
                                    padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlineButton(
                                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                        onPressed: () => print('完善病历'),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.add,size: 20,color: Theme.of(context).primaryColor),
                                            Text(
                                              '帮助患者完善病历',
                                              style: TextStyle(color: Theme.of(context).primaryColor,fontSize: ScreenUtil().setSp(14)),
                                            )
                                          ],
                                        ),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setWidth(10)),
                            Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.white,
                              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                              child: Text('病历档案',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(14))),
                            ),
                          ],
                        ),
                      ),
                      model.busy
                        ? SliverToBoxAdapter(child:Container(height:ScreenUtil().setWidth(240),child: Center(child:CircularProgressIndicator())))
                        : model.error
                        ? SliverToBoxAdapter(child:ViewStateWidget(onPressed: model.initData))
                        : model.empty
                        ? SliverToBoxAdapter(child:Container(height:ScreenUtil().setWidth(240),child: Center(child: Text('暂无病历档案',style: TextStyle(fontSize: ScreenUtil().setSp(14))))))
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
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), ScreenUtil().setWidth(5), ScreenUtil().setWidth(10), ScreenUtil().setWidth(5)),
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
                        borderRadius:BorderRadius.circular(5)),
                    ),
                  )),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(child: SizedBox(
                    child: FlatButton(
                      onPressed: ()=> Navigator.of(context).pushNamed(
                        RouteName.openPrescription,
                        arguments: widget.friend
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        '在线开方',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
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

  Widget _buildGroupItem(String group,bool color) {
    return GestureDetector(
      onTap: () => print(group),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(12)),child: Text(group,style: TextStyle(color:color? Theme.of(context).primaryColor:null,fontSize: ScreenUtil().setSp(15)))),
            Divider(height: 0.5,color: Colors.grey[400]),
          ],
        )
      ),
    );
  }

  Widget _buildFriendInfoHeader(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(120),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      color: Color(0xffe56068),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: widget.friend.headerUrl,
              errorWidget: (context, url, error) => widget.friend.gender == "女"
                ? Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
                width: ScreenUtil().setWidth(55), height: ScreenUtil().setWidth(55))
                : Image.asset(ImageHelper.wrapAssets('gender_boy.png'),
                width: ScreenUtil().setWidth(55), height: ScreenUtil().setWidth(55)),
              fit: BoxFit.fill,
              width: ScreenUtil().setWidth(55),
              height: ScreenUtil().setWidth(55),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(15)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      _displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(16)),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return FriendNameInputDialog(
                              data:_displayName,
                              onConfirm:(text){
                                setState(() {
                                  _displayName = text;
                                });
                              }
                            );
                          });
                      },
                      child: Image.asset(ImageHelper.wrapAssets('ic_edit.png'), width: ScreenUtil().setWidth(18), height: ScreenUtil().setWidth(18)),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(6)),
                  child: Text('真实姓名 ${widget.friend.name}',
                    style: TextStyle(color: Colors.white)),
                ),
                Text(
                  "${_getGender(widget.friend.gender)}${widget.friend.age}岁 | ${widget.friend.phone}",
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
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(5),ScreenUtil().setWidth(15),ScreenUtil().setWidth(5)),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400],width: 0.5),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xfff9f9f9),
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(18),
                    height: ScreenUtil().setWidth(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1
                      )
                    ),
                    child: Text(no.toString(),style: TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(child: Text('诊断记录')),
                  Text(diagnosis.time,style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)))
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('【诊断】',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      SizedBox(width: 5),
                      Expanded(child: Text(diagnosis.diagnosis,style: TextStyle(fontSize: ScreenUtil().setSp(13))))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('【治疗】',style: TextStyle(fontSize: ScreenUtil().setSp(13))),
                      SizedBox(width: 5),
                      Expanded(child: Text(_getDrugsText(diagnosis.drugs),style: TextStyle(fontSize: ScreenUtil().setSp(13)),maxLines: 2))
                    ],
                  ),
                ],
              )
            ),
            Container(color: Colors.grey[300],height: 0.5,margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15))),
            GestureDetector(
              onTap: () => print('查看详情'),
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('查看详情',style: TextStyle(color: Colors.grey[600],fontSize:  ScreenUtil().setSp(13))),
                    SizedBox(width:ScreenUtil().setWidth(5)),
                    Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),width: 6,height: 12)
                  ],
                )
              ),
            )
          ],
        ),
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
