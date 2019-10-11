import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_alert.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/check_message_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CheckMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  TitleBar.buildCommonAppBar(context, '审方消息'),
        body:ProviderWidget<CheckMessageModel>(
          model: CheckMessageModel(),
          onModelReady: (model) {
            model.initData();
          },
          builder: (context, model, child) {
            if (model.busy) {
              return Center(child: CircularProgressIndicator());
            } else if (model.error) {
              return ViewStateWidget(onPressed: model.initData);
            }
            return SmartRefresher(
              controller: model.refreshController,
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: !model.empty,
              child: model.empty ? ViewStateEmptyWidget() : ListView.builder(
                itemCount: model.list?.length ?? 0,
                itemBuilder: (context, index) {
                  return _buildMessageItem(context,index,model);
                },
              ),
            );
          })
    );
  }

  Widget _buildMessageItem(
      BuildContext context, int index,CheckMessageModel model) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(model.list[index].desc, style: TextStyle(fontSize: 16))),
                Text(model.list[index].statusText,
                  style: TextStyle(color: model.list[index].status == 2?Theme.of(context).primaryColor:Colors.red))
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
                      Text(model.list[index].title),
                      SizedBox(height: 10),
                      Text(model.list[index].time,style: TextStyle(color: Colors.grey),)
                    ],
                  )),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 15),
            child: Offstage(
              offstage: model.list[index].status == 2,
              child: SizedBox(
                width: 70,
                height: 30,
                child: OutlineButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogAlert(
                          content: '您确定删除吗？',
                          onPressed: () {
                            model.remove(index);
                            Navigator.maybePop(context);
                          },
                        );
                      });
                  },
                  color: Colors.white,
                  child: Text(
                    '删除',
                    style: TextStyle(color: Colors.grey),
                  ),
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
