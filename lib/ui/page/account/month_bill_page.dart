import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class MonthBillPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '月度账单'),
      body: Container(),
    );
  }

}