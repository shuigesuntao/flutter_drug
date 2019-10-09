import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/law_news.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/law_news_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class LawHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LawNewsModel>(
      model: LawNewsModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        return EasyRefresh(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoad: model.loadMore,
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            emptyWidget: model.empty ? ViewStateEmptyWidget() : null,
            child:Column(
              children: <Widget>[
                Image.asset(
                  ImageHelper.wrapAssets('n29banner.png'),
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 161,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('在线咨询',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16)),
                              SizedBox(height: 10),
                              Text('排忧解惑 提供纠纷解决方案',
                                style: TextStyle(
                                  color: Colors.grey, fontSize: 13)),
                              SizedBox(height: 20),
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  ImageHelper.wrapAssets('n29ermai.png'),
                                  width: 80,
                                  height: 50)),
                              SizedBox(height: 10),
                            ],
                          ),
                        )),
                      VerticalDivider(width: 1, color: Colors.grey[300]),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 80,
                              color: Colors.white,
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('电话咨询',
                                          style: TextStyle(fontSize: 16)),
                                        SizedBox(height: 5),
                                        Text('即使响应 沟通高效',
                                          style: TextStyle(
                                            color: Colors.grey, fontSize: 13))
                                      ],
                                    )),
                                  SizedBox(width: 20),
                                  Image.asset(
                                    ImageHelper.wrapAssets('n29phone.png'),
                                    width: 35,
                                    height: 35)
                                ],
                              ),
                            ),
                            Divider(height: 1, color: Colors.grey[300]),
                            Container(
                              height: 80,
                              color: Colors.white,
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text('律师咨询',
                                            style: TextStyle(fontSize: 16)),
                                        ),
                                        SizedBox(height: 5),
                                        Text('最大优化你的权利',
                                          style: TextStyle(
                                            color: Colors.grey, fontSize: 13))
                                      ],
                                    )),
                                  SizedBox(width: 20),
                                  Image.asset(
                                    ImageHelper.wrapAssets(
                                      'n29findlaywer.png'),
                                    width: 35,
                                    height: 35)
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 3,
                        height: 15,
                        color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text('常见问题解答？',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child:  model.busy? Center(child: CircularProgressIndicator()):ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1),
                    itemCount: model.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildLawNewsItem(context, model.list[index]);
                    },
                  ),
                )
              ],
            )
        );
      },
    );
  }

  Widget _buildLawNewsItem(BuildContext context, LawNews news) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(news.title, style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text(news.content,
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
