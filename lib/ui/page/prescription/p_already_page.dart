import 'package:badges/badges.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/event/event_bus.dart';
import 'package:flutter_drug/event/event_model.dart';
import 'package:flutter_drug/ui/page/prescription/p_list_page.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionAlreadyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrescriptionAlreadyPageState();
}

class _PrescriptionAlreadyPageState extends State<PrescriptionAlreadyPage> {

  _PrescriptionAlreadyPageState() {
    final eventBus = new EventBus();
    ApplicationEvent.event = eventBus;
  }

  int count = 0;
  int unPayCount = 0;
  List<String> tabTitles = ["全部", "未付款", "已付款", "已发货"];
  List<int> status = [0, 1, 2, 3];

  @override
  void initState() {
    super.initState();
    ApplicationEvent.event.on<AlreadyPrescriptionCountEvent>().listen((event) {
      if (this.mounted) {
        setState(() {
          count = event.count;
          unPayCount = event.unPayCount;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar.buildCommonAppBar(context, '已开处方',
            actionIcon: 'icon_ss.png', onActionPress: () =>
            Navigator.of(context).pushNamed(RouteName.prescriptionAlreadySearch), actionTextColor: Colors.black87),
        body: DefaultTabController(
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
                        labelStyle: TextStyle(fontSize:ScreenUtil().setSp(14)),
                        unselectedLabelColor: Colors.black87,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                        tabs: List.generate(
                            tabTitles.length,
                            (index) => index == 1
                                ? Badge(
                                    showBadge: unPayCount > 0,
                                    elevation: 0,
                                    badgeContent: Text(
                                      '$unPayCount',
                                      style: TextStyle(color: Colors.white,fontSize: 12),
                                    ),
                                    position: BadgePosition.topRight(
                                        top: 2, right: -12),
                                    child: Tab(text: tabTitles[index]),
                                  )
                                : Tab(text: index == 0?'${tabTitles[index]}（$count）':tabTitles[index]))),
                  ),
                  Expanded(
                      child: TabBarView(
                    children: List.generate(tabTitles.length,
                        (index) => PrescriptionListPage(status[index])),
                  ))
                ],
              );
            },
          ),
        ));
  }
}
