

import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/page/prescription/prescription_list_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class PrescriptionAlreadyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PrescriptionAlreadyPageState();

}

class _PrescriptionAlreadyPageState extends State<PrescriptionAlreadyPage>{
  List<String> tabTitles = ["全部", "已付款", "已发货"];
  List<int> status = [0,2,3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '已开处方', actionText: '搜索',
        onActionPress: () {
          print('点击了搜索');
        },actionTextColor: Colors.black87),
      body:DefaultTabController(
        length: tabTitles.length,
        initialIndex: 0,
        child: Builder(
          builder: (context) {
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black87,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: List.generate(tabTitles.length, (index) => Tab(text: tabTitles[index]))
                  ),
                ),
                Expanded(child: TabBarView(
                  children: List.generate(tabTitles.length, (index) => PrescriptionListPage(status[index])),
                ))
              ],
            );
          },
        ),
      )
    );
  }

}