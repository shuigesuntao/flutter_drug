import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/law_news.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/law_news_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LawHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LawNewsModel>(
      model: LawNewsModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        return SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child:  CustomScrollView(
              slivers: <Widget>[
                // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        ImageHelper.wrapAssets('n29banner.png'),
                        width: double.infinity,
                        height: ScreenUtil().setWidth(140),
                        fit: BoxFit.fill,
                      ),
                      Container(
                        color: Colors.white,
                        height: ScreenUtil().setWidth(161),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(12), ScreenUtil().setWidth(20), ScreenUtil().setWidth(12), 0),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('在线咨询',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: ScreenUtil().setSp(16))),
                                    SizedBox(height: ScreenUtil().setWidth(10)),
                                    Text('排忧解惑 提供纠纷解决方案',
                                      style: TextStyle(
                                        color: Colors.grey, fontSize: ScreenUtil().setSp(12))),
                                    SizedBox(height: ScreenUtil().setWidth(20)),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        ImageHelper.wrapAssets('n29ermai.png'),
                                        width: ScreenUtil().setWidth(80),
                                        height: ScreenUtil().setWidth(50))),
                                    SizedBox(height: ScreenUtil().setWidth(10)),
                                  ],
                                ),
                              )),
                            VerticalDivider(width: 1, color: Colors.grey[400]),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('电话咨询', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                                                SizedBox(height: ScreenUtil().setWidth(5)),
                                                Text('即使响应 沟通高效', style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(13)))
                                              ],
                                            )),
                                          Image.asset(
                                            ImageHelper.wrapAssets('n29phone.png'),
                                            width: ScreenUtil().setWidth(32),
                                            height: ScreenUtil().setWidth(322))
                                        ],
                                      ),
                                    )
                                  ),
                                  Divider(height: 1, color: Colors.grey[400]),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('律师咨询', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                                                SizedBox(height: ScreenUtil().setWidth(5)),
                                                Text('最大优化你的权利', style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(13)))
                                              ],
                                            )),
                                          Image.asset(
                                            ImageHelper.wrapAssets(
                                              'n29findlaywer.png'),
                                            width: ScreenUtil().setWidth(32),
                                            height: ScreenUtil().setWidth(32))
                                        ]),
                                    )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(3),
                              height: ScreenUtil().setWidth(15),
                              color: Theme.of(context).primaryColor),
                            SizedBox(width: ScreenUtil().setWidth(5)),
                            Expanded(
                              child: Text('常见问题解答？',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: ScreenUtil().setSp(16)))),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                model.busy
                  ? SliverToBoxAdapter(child: Container(height:400,alignment:Alignment.center,child: CircularProgressIndicator()))
                  : model.error
                    ? ViewStateWidget(onPressed: model.initData)
                    : model.empty
                      ? ViewStateEmptyWidget()
                      : SliverList(delegate: SliverChildBuilderDelegate((context,index) => _buildLawNewsItem(context,model.list[index]), childCount:model.list.length),
                ),
              ],
            ),
        );
      },
    );
  }

  Widget _buildLawNewsItem(BuildContext context, LawNews news) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(25), ScreenUtil().setWidth(20), ScreenUtil().setWidth(25)),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(news.title, style: TextStyle(fontSize: ScreenUtil().setSp(16))),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Text(news.content,
                style: TextStyle(color: Colors.grey[500],fontSize: ScreenUtil().setSp(14)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        Divider(height: 1,color: Colors.grey[100],)
      ],
    );
  }
}
