import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/banner_image.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:flutter_drug/view_model/home_model.dart';
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
      Provider.of<FriendModel>(context).initData();
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
    return ProviderWidget<HomeModel>(
        model: HomeModel(),
        onModelReady: (homeModel) {
          homeModel.initData();
        },
        builder: (context, homeModel, child) {
          return Scaffold(
            appBar: TitleBar.buildCommonAppBar(
              context,
              '中医工作室',
              actionText: '客服',
              isShowBack: false,
              onActionPress: ()=> showDialog(
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
                        onPressed: () => callPhone('400 052 0120'),
                      ),
                    ],
                  );
                })
            ),
            body: homeModel.error?ViewStateWidget(onPressed: homeModel.initData): SmartRefresher(
              controller: homeModel.refreshController,
              onRefresh: homeModel.refresh,
              //防止软键盘超出
              child:SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    BannerWidget(),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                HomeItemWidget(
                                  '添加患者',
                                  'ic_yqhz.png',
                                  onClick: () =>
                                    nextPage(RouteName.addPatient),
                                ),
                                HomeItemWidget(
                                  '在线开方',
                                  'ic_zxkf.png',
                                  onClick: () =>
                                    nextPage(RouteName.openPrescription),
                                ),
                                HomeItemWidget(
                                  '拍方上传',
                                  'ic_pfsc.png',
                                  onClick: () => nextPage(RouteName.takePrescription),
                                ),
                                Badge(
                                  padding: EdgeInsets.all(7),
                                  elevation: 0,
                                  badgeContent: Text('1',style: TextStyle(color: Colors.white),),
                                  position: BadgePosition.topRight(top: -6, right: 1),
                                  child: HomeItemWidget(
                                    '审方消息',
                                    'ic_sfxx.png',
                                    onClick: () => nextPage(RouteName.checkMessage),
                                  ),
                                ),
                              ],
                            )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                HomeItemWidget(
                                  '处方模板',
                                  'ic_cfmb.png',
                                  onClick: () =>
                                    nextPage(RouteName.prescriptionFormWork),
                                ),
                                HomeItemWidget(
                                  '服务设置',
                                  'ic_szcz.png',
                                  onClick: () =>
                                    nextPage(RouteName.serviceSetting),
                                ),
                                HomeItemWidget(
                                  '发布公告',
                                  'ic_fbgg.png',
                                  onClick: () =>
                                    nextPage(RouteName.publishNotice),
                                ),
                                HomeItemWidget(
                                  '已开处方',
                                  'ic_ykcf.png',
                                  onClick: () =>
                                    nextPage(RouteName.prescriptionAlready),
                                ),
                              ],
                            )),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        ImageHelper.wrapAssets('yqys.png'),
                      ),
                    )
                  ],
                ),
              )
              ),
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
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 5 / 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Consumer<HomeModel>(builder: (_, homeModel, __) {
            if (homeModel.busy) {
              return CupertinoActivityIndicator();
            } else {
              var banners = homeModel?.banners ?? [];
              return Swiper(
                loop: true,
                autoplay: true,
                autoplayDelay: 5000,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        size: 8.0, activeSize: 8.0, space: 5.0)),
                itemCount: banners.length,
                itemBuilder: (ctx, index) {
                  return BannerImage(banners[index].imagePath);
//                return InkWell(
//                  onTap: () {
//                    var banner = banners[index];
//                    Navigator.of(context).pushNamed(RouteName.articleDetail,
//                      arguments: Article()
//                        ..id = banner.id
//                        ..title = banner.title
//                        ..link = banner.url
//                        ..collect = false);
//                  },
//                  child: BannerImage(banners[index].imagePath));
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
  final Function onClick;

  const HomeItemWidget(this.label, this.url, {this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              ImageHelper.wrapAssets(url),
              width: 30,
              height: 30,
            ),
          ),
          Text(
            label,
          )
        ],
      ),
    );
  }
}
