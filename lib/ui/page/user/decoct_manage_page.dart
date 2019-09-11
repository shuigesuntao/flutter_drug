import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/decoct_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class DecoctManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar.buildCommonAppBar(context, '入煎方法',
          actionText: '添加', onActionPress: () => print("点击了添加")),
      body: ProviderWidget<DecoctModel>(
        model: DecoctModel(),
        onModelReady: (decoctModel) {
          decoctModel.initData();
        },
        builder: (context, decoctModel, child) {
          return decoctModel.busy
              ? Center(child: CircularProgressIndicator())
              : MediaQuery.removePadding(
                  context: context,
                  removeTop: false,
                  child: EasyRefresh(
                    controller: decoctModel.refreshController,
                    onRefresh: decoctModel.refresh,
                    enableControlFinishRefresh: true,
                    emptyWidget:
                        decoctModel.empty ? ViewStateEmptyWidget() : null,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 1),
                      itemCount: decoctModel.list?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                          decoctModel.list[index].name,
                          style: TextStyle(fontSize: 16),
                        ));
                      },
                    ),
                  ));
        },
      ),
    );
  }
}
