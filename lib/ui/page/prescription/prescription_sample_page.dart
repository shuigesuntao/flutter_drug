
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class PrescriptionSamplePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '处方笺'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Image.asset(ImageHelper.wrapAssets('pfshl.png')),
      ),
    );
  }

}