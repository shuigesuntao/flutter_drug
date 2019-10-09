import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class InsurancePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Image.asset(ImageHelper.wrapAssets('security_banner.png'),width: double.infinity,height: 140,fit: BoxFit.fill),
      ],
    );
  }

}