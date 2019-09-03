

import 'package:flutter/material.dart';

class DialogImagePicker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: EdgeInsets.all(10),
      child:Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){

                  },
                  child: Padding(padding: EdgeInsets.all(10),child: Text('从相册选择',style: TextStyle(fontSize: 18,color: Colors.blue[800]))),
                ),
                Divider(height: 1,color: Colors.grey,),
                InkWell(
                  onTap: (){

                  },
                  child: Padding(padding: EdgeInsets.all(10),child: Text('拍照',style: TextStyle(fontSize: 18,color: Colors.blue[800]))),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: InkWell(
              onTap: ()=> Navigator.pop(context),
              child: Padding(padding: EdgeInsets.all(10),child: Text('取消',style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.bold))),
            ),
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

}