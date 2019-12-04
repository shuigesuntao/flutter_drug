import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/page/user/patient_list_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class PatientTabPage extends StatefulWidget{

  final int type; //1 待随访 2 待复诊

  PatientTabPage({this.type});

  @override
  State<StatefulWidget> createState() => _PatientTabPageState();

}

class _PatientTabPageState extends State<PatientTabPage>{

  List<String> tabTitles = ['今日(0)', '全部(0)'];
  List<int> status = [1,2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, widget.type == 1?'待随访患者':'待复诊患者',actionTextColor:Color(0xffeaaf4c),actionText: widget.type == 1? '随访说明':null,onActionPress: (){
        Navigator.of(context).pushNamed(RouteName.followUp);
      }),
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
                    labelStyle:TextStyle(fontSize: 16),
                    unselectedLabelColor: Colors.black87,
                    indicatorWeight: 3,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: List.generate(tabTitles.length, (index) => Tab(text: tabTitles[index]))
                  ),
                ),
                Expanded(child: TabBarView(
                  children: List.generate(tabTitles.length, (index) => PatientListPage(status:status[index],type: widget.type)),
                ))
              ],
            );
          },
        ),
      )
    );
  }
}