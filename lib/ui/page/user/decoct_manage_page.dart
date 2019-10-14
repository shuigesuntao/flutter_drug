import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_add_dococt.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/decoct_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DecoctManagePage extends StatelessWidget {
  final SlidableController _controller = SlidableController();
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DecoctModel>(
        model: DecoctModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: TitleBar.buildCommonAppBar(context, '入煎方法',
                actionText: '添加',
                onActionPress: () => showDialog(
                    context: context, //BuildContext对象
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return DecoctAddDialog(onConfirm: (text) {
                        model.add(text);
                      });
                    })),
            body: _buildBody(model)
          );
        });
  }

  _buildBody(DecoctModel model) {
    if (model.busy) {
      return Center(child: CircularProgressIndicator());
    } else if (model.error) {
      return ViewStateWidget(onPressed: model.initData);
    }
    return SmartRefresher(
      controller: model.refreshController,
      onRefresh: model.refresh,
      child: model.empty
        ? ViewStateEmptyWidget()
        : ListView.separated(
          separatorBuilder: (context,index) => Divider(height: 1),
          itemCount: model.list?.length ?? 0,
          itemBuilder: (context, index) {
            return Slidable(
              controller: _controller,
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                SlideAction(
                  child: Text('删除',style: TextStyle(color: Colors.white)),
                  color: Colors.redAccent,
                  onTap: () => model.remove(index),
                )
              ],
              child: ListTile(
                onTap: (){
                  _controller.activeState?.close();
                },
                title: Text(
                  model.list[index].name,
                  style: TextStyle(fontSize: 16),
                )),
            );
        },
      ),
    );
  }
}
