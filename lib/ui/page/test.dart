

import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(
        context,
        '设置中心',
      ),
      body: Container(),
    );
  }

}