import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/banner_image.dart';
import 'package:flutter_drug/ui/widget/dialog_main_tip.dart';
import 'package:flutter_drug/ui/widget/me_header.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:flutter_drug/view_model/home_model.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
  with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<FriendModel>(context,listen: false).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
//    var size = MediaQuery.of(context).size;

//    /// iPhoneX 头部适配
//    var top = MediaQuery.of(context).padding.top;
//    var bannerHeight = size.width * 9 / 16 - top;
    UserModel model = Provider.of<UserModel>(context,listen: false);
    return ProviderWidget<HomeModel>(
      model: HomeModel(),
      onModelReady: (homeModel) {
        homeModel.initData();
      },
      builder: (context, homeModel, child) {
        return Scaffold(
          appBar:
          TitleBar.buildCommonAppBar(context, '工作室', isShowBack: false),
          body: homeModel.isError
            ? ViewStateWidget(onPressed: homeModel.initData)
            : SmartRefresher(
            controller: homeModel.refreshController,
            onRefresh: homeModel.refresh,
            //防止软键盘超出
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                    color: Colors.white,
                    child: UserInfoHeader(
                      imageUrl: model.user?.icon,
                      name: '${model.user?.name}的个人工作室',
                      type: model.user?.type,
                      job: model.user?.level,
                      hasRightIcon: false,
                      isLogin: model.hasUser,
                      onButtonClick: () {
                        if (model.hasUser) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('400 052 0120'),
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
                                    onPressed: () =>
                                      callPhone('400 052 0120'),
                                  ),
                                ],
                              );
                            });
                        } else {
                          Navigator.of(context).pushNamed(RouteName.login);
                        }
                      },
                    )
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            HomeItemWidget(
                              '添加患者',
                              'icon_yqhz.png',
                              onClick: () =>
                                nextPage(RouteName.addPatient),
                            ),
                            HomeItemWidget(
                              '在线开方',
                              'icon_zxkf.png',
                              onClick: () =>
                                nextPage(RouteName.choosePerson),
                            ),
                            HomeItemWidget(
                              '拍方上传',
                              'icon_pfsc.png',
                              onClick: () =>
                                nextPage(RouteName.takePrescription),
                            ),
                            Badge(
                              padding: EdgeInsets.all(7),
                              elevation: 0,
                              badgeContent: Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                              position: BadgePosition.topRight(
                                top: -8, right: 5),
                              child: HomeItemWidget(
                                '审方消息',
                                'icon_sfxx.png',
                                onClick: () =>
                                  nextPage(RouteName.checkMessage),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(20)),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            HomeItemWidget(
                              '处方模板',
                              'icon_cfmb.png',
                              onClick: () =>
                                Navigator.of(context)
                                  .pushNamed(
                                  RouteName.prescriptionFormWork,
                                  arguments: false),
                            ),
                            HomeItemWidget(
                              '服务设置',
                              'icon_szcz.png',
                              onClick: () =>
                                nextPage(RouteName.serviceSetting),
                            ),
                            HomeItemWidget(
                              '发布公告',
                              'icon_fbgg.png',
                              onClick: () =>
                                nextPage(RouteName.publishNotice),
                            ),
                            HomeItemWidget(
                              '已开处方',
                              'icon_ykcf.png',
                              onClick: () =>
                                nextPage(RouteName.prescriptionAlready),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(5)),
                  _buildBanner(),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), ScreenUtil().setWidth(5), ScreenUtil().setWidth(10), ScreenUtil().setWidth(5)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _buildMainItem(
                              () =>
                              Navigator.of(context)
                                .pushNamed(RouteName.inviteDoctor),
                            Color(0xfffff4f0),
                            '推荐有奖',
                            '推荐同行，各得49元现金',
                            'icon_tjyj.png'),
                          SizedBox(width: 5),
                          _buildMainItem(
                              () =>
                              _goToWebPage(
                                context,
                                '专属药房',
                                'http://wx.zgzydb.com/web4/yxzinformation/#/pharmacy',
                                true),
                            Color(0xfffbf9ea),
                            '专属药房',
                            '品类齐全，品质保证',
                            'icon_zsyf.png'),
                          SizedBox(width: 5),
                          _buildMainItem(
                              () =>
                              _goToWebPage(
                                context,
                                '开方指南',
                                'http://wx.zgzydb.com/web4/yxzinformation/#/preguide',
                                true),
                            Color(0xfffef4e9),
                            '开方指南',
                            '线上开方，送药到家',
                            'icon_kfzn.png'),
                        ],
                      )),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      if (!model.hasUser) {
                        Navigator.of(context).pushNamed(RouteName.login);
                      } else {
                        Navigator.of(context).pushNamed(RouteName.messageNote);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            ImageHelper.wrapAssets('icon_xiaoxi.png'),
                            width: ScreenUtil().setWidth(45),
                            height: ScreenUtil().setWidth(45)),
                          SizedBox(width: ScreenUtil().setWidth(15)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('消息通知',
                                  style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                                SizedBox(height: 3),
                                Text('暂无消息通知',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: ScreenUtil().setSp(12)))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )

                ],
              )),
          ),
        );
      });
  }

  void callPhone(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  void nextPage(String name) {
    Navigator.of(context).pushNamed(name);
  }

  _goToWebPage(BuildContext context, String title, String url, bool isShare) {
    Map map = Map();
    map['title'] = title;
    map['url'] = url;
    map['share'] = isShare;
    Navigator.of(context).pushNamed(RouteName.webView, arguments: map);
  }

  Widget _buildMainItem(VoidCallback onTap, Color backgroundColor, String title,
    String subTitle, String icon) {
    return GestureDetector(
      onTap: (){
        if(Provider
          .of<UserModel>(context,listen: false)
          .hasUser){
          onTap();
        }else{
          Navigator.of(context).pushNamed(RouteName.login);
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(152),
        decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10),ScreenUtil().setWidth(12),ScreenUtil().setWidth(10),ScreenUtil().setWidth(12)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                  SizedBox(height: 1),
                  Text(subTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[400], fontSize: ScreenUtil().setSp(10)))
                ],
              )),
            Image.asset(ImageHelper.wrapAssets(icon), width: ScreenUtil().setWidth(25), height: ScreenUtil().setWidth(25))
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return AspectRatio(
      aspectRatio: 4 / 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        ),
        child: Consumer<HomeModel>(builder: (_, model, __) {
          if (model.isBusy) {
            return CupertinoActivityIndicator();
          } else {
            return Swiper(
              loop: model.list.length > 1,
              autoplay: model.list.length > 1,
              autoplayDelay: 3000,
              itemCount: model.list.length,
              pagination: model.list.length > 1
                ? SwiperPagination(
                margin: EdgeInsets.only(bottom: 2),
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.white,
                  color: Colors.grey[350],
                  size: 6,
                  activeSize: 6))
                : null,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                    _goToWebPage(context,
                      model.list[index].title, model.list[index].url, true),
                  child: BannerImage(model.list[index].image));
              },
            );
          }
        }),
      ));
  }
}

class HomeItemWidget extends StatelessWidget {
  final String label;
  final String url;
  final VoidCallback onClick;

  const HomeItemWidget(this.label, this.url, {this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Provider.of<UserModel>(context,listen: false).hasUser) {
          onClick();
        } else {
          Navigator.of(context).pushNamed(RouteName.login);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(6),
            child: Image.asset(
              ImageHelper.wrapAssets(url),
              width: ScreenUtil().setWidth(25),
              height: ScreenUtil().setWidth(25),
            ),
          ),
          Text(label,style: TextStyle(fontSize: ScreenUtil().setSp(14)))
        ],
      ),
    );
  }
}
