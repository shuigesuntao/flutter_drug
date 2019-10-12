

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class UserInfoHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String job;
  final bool hasRightIcon;
  UserInfoHeader({
    this.imageUrl,
    this.name,
    this.type,
    this.job,
    this.hasRightIcon = true});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill)
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              ),
              Text(
                '$type | $job',
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          )
        ),
        Offstage(
          offstage: !hasRightIcon,
          child:Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}