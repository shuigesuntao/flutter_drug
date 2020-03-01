import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/message_note_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageNotePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '消息通知'),
      body: ProviderWidget<MessageNoteModel>(
        model: MessageNoteModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.isBusy) {
            return Center(child: CircularProgressIndicator());
          } else if (model.isError) {
            return ViewStateWidget(onPressed: model.initData);
          }
          return SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: model.isEmpty
              ? ViewStateEmptyWidget()
              : ListView.builder(
              itemCount: model.list?.length ?? 0,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          );
        }),
    );
  }
  
}