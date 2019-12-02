

import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/page/prescription/p_formwork_list_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';

class PrescriptionFormWorkPage extends StatefulWidget{

  final bool hasHistory;

  PrescriptionFormWorkPage({this.hasHistory = false});

  @override
  State<StatefulWidget> createState() => _PrescriptionFormWorkPageState();

}

class _PrescriptionFormWorkPageState extends State<PrescriptionFormWorkPage>{

  List<String> tabTitles = ['常用处方', '经方模板'];
  List<int> status = [1,2];
  TabController tabController;
  int _index = 0;


  @override
  void initState() {
    if(widget.hasHistory){
      tabTitles.insert(0, '历史处方');
      status.insert(0,3);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('处方模板',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18)),
        leading: TitleBar.leading(context,null),
        actions: <Widget>[
          GestureDetector(
            onTap: ()=>Navigator.of(context).pushNamed(RouteName.prescriptionFormWorkSearch),
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(ImageHelper.wrapAssets('icon_ss.png'),width: 20,height: 20),
            ),
          ),
          Offstage(
            offstage: _index != 0 || widget.hasHistory,
            child: InkWell(
              onTap: ()=>print('添加'),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(ImageHelper.wrapAssets('icon_xj.png'),width: 20,height: 20),
              ),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body:DefaultTabController(
        length: tabTitles.length,
        initialIndex: 0,
        child: Builder(
          builder: (context) {
            if (tabController == null) {
              tabController = DefaultTabController.of(context);
              tabController.addListener(() {
                setState(() {
                  _index = tabController.index;
                });
              });
            }
            return Column(
              children: <Widget>[
                Divider(height: 1,color: Colors.grey[200]),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle:TextStyle(fontSize: 16),
                    unselectedLabelColor: Colors.black87,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: List.generate(tabTitles.length, (index) => Tab(text: tabTitles[index]))
                  ),
                ),
                Expanded(child: TabBarView(
                  children: List.generate(tabTitles.length, (index) => PrescriptionFormWorkListPage(status[index],hasHistory: widget.hasHistory)),
                ))
              ],
            );
          },
        ),
      )
    );
  }
}