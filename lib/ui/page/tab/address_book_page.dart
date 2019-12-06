import 'package:azlistview/azlistview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/ui/page/search/p_person_search_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class AddressBookPage extends StatefulWidget {
  final Function(Friend) onItemClick;

  AddressBookPage({this.onItemClick});

  @override
  State<StatefulWidget> createState() => _AddressBookPageState();

}

class _AddressBookPageState extends State<AddressBookPage>
  with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<FriendModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: widget.onItemClick == null ? null : TitleBar.leading(
            context, () => Navigator.maybePop(context)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('全部',style: TextStyle(color: Colors.black,fontWeight:FontWeight.normal,fontSize: ScreenUtil().setSp(17))),
              Text(' (${model.list?.length ?? 0}) ',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(13))),
              Image.asset(ImageHelper.wrapAssets('icon_qiehuan.png'),
                width: 12, height: 7)
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  if (widget.onItemClick == null) {
                    Navigator.of(context).pushNamed(
                      RouteName.prescriptionPersonSearch, arguments: 1);
                  } else {
                    Navigator.push(context, CupertinoPageRoute(builder: (
                      context) => PrescriptionPersonSearchPage(
                      onItemClick: widget.onItemClick))).then((data) {
                      if (data == 'pop') {
                        Navigator.maybePop(context);
                      }
                    });
                  }
                },
                child: Center(
                  child: Text(
                    '搜索',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                ),
              ))
          ],
        ),
        body: model.busy
          ? Center(child: CircularProgressIndicator())
          : AzListView(
          data: model.list,
          itemBuilder: (context, model) =>
            FriendItemWidget(
              friend: model,
              onItemClick: (model) {
                if (widget.onItemClick == null) {
                  Navigator.of(context).pushNamed(
                    RouteName.friendInfo, arguments: model);
                } else {
                  widget.onItemClick(model);
                  Navigator.maybePop(context);
                }
              },
              isShowIndex: model.isShowSuspension
            ),
          indexBarBuilder:(BuildContext context, List<String> tags, IndexBarTouchCallback onTouch){
            return IndexBar(
              textStyle:TextStyle(fontSize: ScreenUtil().setSp(12)),
              touchDownTextStyle:TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.grey),
              touchDownColor: Colors.transparent,
              data: tags,
              onTouch: onTouch,
            );
          },
          suspensionWidget: SusWidget(tag: model.suspensionTag),
          isUseRealIndex: true,
          itemHeight: 60,
          suspensionHeight: 30,
          onSusTagChanged: (String tag) => model.suspensionTag = tag,
        ),
      );
    });
  }
}


class FriendItemWidget extends StatelessWidget {
  final Friend friend;
  final Function(Friend) onItemClick;
  final bool isShowIndex;

  FriendItemWidget(
    {@required this.friend, this.onItemClick, this.isShowIndex = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !isShowIndex,
          child: SusWidget(tag: friend.getSuspensionTag()),
        ),
        GestureDetector(
          onTap: () => onItemClick(friend),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: friend.headerUrl,
                    errorWidget: (context, url, error) =>
                    friend.gender == '女'
                      ? Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
                      width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40))
                      : Image.asset(ImageHelper.wrapAssets('gender_boy.png'),
                      width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)),
                    fit: BoxFit.fill,
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              friend.displayName,
                              style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                            ),
                            Offstage(
                              offstage:
                              friend.name == null || friend.name.isEmpty,
                              child: Text('（${friend.name}）',
                                style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14))),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xff999999), width: 0.5),
                                borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: <Widget>[
                                   Offstage(
                                      offstage: friend.gender == null ||
                                        friend.gender.isEmpty,
                                      child: Padding(padding: EdgeInsets.only(right: 5),
                                        child:Image.asset(ImageHelper.wrapAssets(
                                        friend.gender == '女'
                                          ? 'icon_girl.png'
                                          : 'icon_boy.png'), width: ScreenUtil().setWidth(12),
                                        height: ScreenUtil().setWidth(12))
                                      ),
                                    ),
                                  Text('${friend.age} 岁', style: TextStyle(
                                    color: Colors.grey, fontSize: 12))
                                ],
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Text(
                              '问诊${friend.askCount}次 | 购药${friend.buyDrugCount}次',
                              style: TextStyle(
                                color: Colors.grey, fontSize: ScreenUtil().setSp(12)),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
              ],
            )),
        ),
        Divider(height: 0.5,color: Colors.grey[300])
      ],
    );
  }
}

class SusWidget extends StatelessWidget {
  final String tag;

  SusWidget({@required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(30),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: TextStyle(
          color: Colors.black87,fontSize: ScreenUtil().setSp(14)
        ),
      ),
    );
  }

}
