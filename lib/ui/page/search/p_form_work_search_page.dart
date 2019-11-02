import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/page/prescription/p_formwork_list_page.dart';
import 'package:flutter_drug/ui/widget/search_bar.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PrescriptionFormWorkSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
          hintText: "按处方名检索",
          onPressed: (text) {
            showToast("搜索内容：$text");
          },
        ),
        body: ProviderWidget<PrescriptionFormWorkListModel>(
          model: PrescriptionFormWorkListModel(0),
          builder: (context,model,child){
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
              child: model.empty ? ViewStateEmptyWidget() :ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  return PrescriptionFormWorkItem(model.list[index]);
                })
            );
          }
        )
    );
  }
}
