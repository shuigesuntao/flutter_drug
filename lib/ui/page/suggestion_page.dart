import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class SuggestionPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '意见反馈'),
    );
  }

}