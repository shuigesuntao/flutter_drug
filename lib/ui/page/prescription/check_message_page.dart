import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/model/check_message.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/check_message_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CheckMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  TitleBar.buildCommonAppBar(context, '审方消息'),
        body: Column(
          children: <Widget>[
            Divider(height: 1),
            Expanded(child: ProviderWidget<CheckMessageModel>(
              model: CheckMessageModel(),
              onModelReady: (model) {
                model.initData();
              },
              builder: (context, model, child) {
                return EasyRefresh(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  enableControlFinishRefresh: true,
                  firstRefresh: true,
                  firstRefreshWidget: Center(child: CircularProgressIndicator()),
                  emptyWidget: model.empty ? ViewStateEmptyWidget() : null,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1),
                    itemCount: model.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildMessageItem(context,model.list[index]);
                    },
                  ),
                );
              }))
          ],
        ));
  }

  Widget _buildMessageItem(
      BuildContext context, CheckMessage checkMessage) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(checkMessage.desc, style: TextStyle(fontSize: 16))),
                Text(checkMessage.statusText,
                  style: TextStyle(color: Theme.of(context).primaryColor))
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey, indent: 15),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(checkMessage.title),
                      SizedBox(height: 10),
                      Text(checkMessage.time,style: TextStyle(color: Colors.grey),)
                    ],
                  )),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
