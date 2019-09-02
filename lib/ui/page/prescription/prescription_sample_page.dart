
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class PrescriptionSamplePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Text('处方笺'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Image.asset(ImageHelper.wrapAssets('pfshl.png')),
      ),
    );
  }

}