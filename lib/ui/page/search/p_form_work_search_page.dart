import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/page/prescription/p_formwork_list_page.dart';
import 'package:flutter_drug/ui/widget/search_bar.dart';
import 'package:flutter_drug/view_model/prescription_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:oktoast/oktoast.dart';

class PrescriptionFormWorkSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
          hintText: "按处方名称搜索",
          onPressed: (text) {
            showToast("搜索内容：$text");
          },
        ),
        body: ProviderWidget(
          model: PrescriptionFormWorkListModel(0),
          builder: (_,model,__){
            return EasyRefresh(
              controller: model.refreshController,
              onRefresh: model.refresh,
              onLoad: model.loadMore,
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              emptyWidget: model.empty ? ViewStateEmptyWidget() : null,
              child: ListView.builder(
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
