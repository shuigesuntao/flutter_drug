import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/widget/search_bar.dart';
import 'package:flutter_drug/view_model/firend_model.dart';
import 'package:provider/provider.dart';

class PrescriptionPersonSearchPage extends StatefulWidget {
  final int type;
  PrescriptionPersonSearchPage({this.type});
  @override
  State<StatefulWidget> createState() => _PrescriptionPersonSearchPageState();
}

class _PrescriptionPersonSearchPageState extends State<PrescriptionPersonSearchPage>{
  @override
  Widget build(BuildContext context) {
    FriendModel model = Provider.of<FriendModel>(context);
    return Scaffold(
      appBar: SearchBar(
        hintText: "请输入患者姓名或电话号码搜索",
        onPressed: (text) {
          model.filterData(text);
        },
        onChanged: (String text) {
          if (text.isEmpty){
            model.filterData(text);
          }
        },
      ),
      body: ListView.builder(
        itemCount: model.filterList.length,
        itemBuilder: (context, index) {
          return FriendItemWidget(
            friend:model.filterList[index],
            onItemClick:(model){
              switch(widget.type){
                //患者信息
                case 1:
                  Navigator.of(context).pushNamed(
                    RouteName.friendInfo,
                    arguments: model
                  );
                  break;
                //在线开方
                case 2:
                  Navigator.of(context).pushNamed(
                    RouteName.openPrescription,
                    arguments: model
                  );
                  break;
              }
            },
            isShowIndex:false);
        }
      )
    );
  }
}
