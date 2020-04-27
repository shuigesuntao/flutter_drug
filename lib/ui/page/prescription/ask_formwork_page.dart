import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/ask_model.dart';
import 'package:flutter_drug/view_model/check_message_model.dart';

class AskFormWorkPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '问诊单'),
      body: ProviderWidget<AskModel>(
        model: AskModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.list?.length ?? 0,
            itemBuilder: (context, index) {
              return _buildAksListItem(context, index, model);
            },
          );
        }));
  }

  Widget _buildAksListItem( BuildContext context, int index, AskModel model){

  }
}