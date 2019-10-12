
import 'package:flutter/material.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class PrescriptionOpenPage extends StatefulWidget{
  final Friend friend;
  PrescriptionOpenPage({this.friend});

  @override
  State<StatefulWidget> createState() => PrescriptionOpenPageState();

}

class PrescriptionOpenPageState extends State<PrescriptionOpenPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '在线开方'),
    );
  }

}