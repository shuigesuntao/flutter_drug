import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/widget/search_bar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:provider/provider.dart';

class PrescriptionPersonSearchPage extends StatefulWidget {
  final Function(Friend) onItemClick;
  final int type;

  PrescriptionPersonSearchPage({this.type, this.onItemClick});

  @override
  State<StatefulWidget> createState() => _PrescriptionPersonSearchPageState();
}

class _PrescriptionPersonSearchPageState
    extends State<PrescriptionPersonSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FriendModel>(builder: (context, model, child) {
      return WillPopScope(
        child: Scaffold(
            appBar: SearchBar(
              hintText: "请输入患者姓名或电话号码搜索",
              onPressed: (text) {
                model.filterData(text);
              },
              onChanged: (String text) {
                if (text.isEmpty) {
                  model.filterData(text);
                }
              },
            ),
            body: model.busy
                ? Center(child: CircularProgressIndicator())
                : model.error
                    ? ViewStateWidget(onPressed: model.initData)
                    : model.empty
                        ? ViewStateEmptyWidget(image: 'wssjg.png',message: '搜索无结果')
                        : ListView.builder(
                            itemCount: model.filterList.length,
                            itemBuilder: (_, index) {
                              return FriendItemWidget(
                                  friend: model.filterList[index],
                                  onItemClick: (friend) {
                                    if (widget.onItemClick == null) {
                                      switch (widget.type) {
                                        //患者信息
                                        case 1:
                                          Navigator.of(context).pushNamed(
                                              RouteName.friendInfo,
                                              arguments: friend);
                                          break;
                                        //在线开方
                                        case 2:
                                          Navigator.of(context).pushNamed(
                                              RouteName.openPrescription,
                                              arguments: friend);
                                          break;
                                      }
                                    } else {
                                      model.filterData('');
                                      widget.onItemClick(friend);
                                      Navigator.pop(context, 'pop');
                                    }
                                  },
                                  isShowIndex: false);
                            })),
        onWillPop: () {
          model.filterData('');
          return Future.value(true);
        },
      );
    });
  }
}
