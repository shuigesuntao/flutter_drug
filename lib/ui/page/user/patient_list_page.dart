
import 'package:flutter/material.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/view_model/patient_list_model.dart';

class PatientListPage extends StatelessWidget{
  final int status;
  final int type;

  PatientListPage({this.type,this.status});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PatientListModel>(
      model: PatientListModel(status),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return Center(child: CircularProgressIndicator());
        } else if (model.isError) {
          return ViewStateWidget(onPressed: model.initData);
        }
        return model.isEmpty ? ViewStateEmptyWidget() : ListView.builder(
          itemCount: model.list.length,
          itemBuilder: (context, index) {
            return Container();
          }
        );
      },
    );
  }

}