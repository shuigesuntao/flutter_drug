

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class UserInfoHeader extends StatelessWidget {
  final String headerBg;
  final String imageUrl;
  final String name;
  final String type;
  final String job;
  final EdgeInsetsGeometry margin;
  final bool hasRightIcon;
  UserInfoHeader({this.headerBg,
    this.imageUrl,
    this.name,
    this.type,
    this.job,
    this.margin,
    this.hasRightIcon = true});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: margin,
          height: 130,
          child: Image.asset(ImageHelper.wrapAssets(headerBg),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(40,0,30,0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fill)
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            type,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Container(
                            width: 2,
                            height: 13,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.white,
                          ),
                          Text(
                            job,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: !hasRightIcon,
                child:Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}