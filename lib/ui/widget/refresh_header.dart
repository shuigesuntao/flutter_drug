import 'package:flutter/material.dart' hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends RefreshIndicator{
  RefreshHeader() : super(height: 80.0, refreshStyle: RefreshStyle.Follow);
  @override
  State<StatefulWidget> createState() => _RefreshHeaderState();
}

class _RefreshHeaderState extends RefreshIndicatorState<RefreshHeader> with SingleTickerProviderStateMixin{
  String _tip = '下拉刷新';

  @override
  void onModeChange(RefreshStatus mode) {
    if(mode == RefreshStatus.idle){
      setState(() {
        _tip = '下拉刷新';
      });
    }
    if(mode == RefreshStatus.canRefresh){
      setState(() {
        _tip = '释放立即刷新';
      });
    }
    if (mode == RefreshStatus.refreshing ) {
      setState(() {
        _tip = '正在刷新...';
      });
    }
    super.onModeChange(mode);
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Column(
      children: <Widget>[
        Image.asset(ImageHelper.wrapAssets('lodigngif.gif'),width: 30,height: 30),
        SizedBox(height: 10),
        Text(_tip,style: TextStyle(fontSize: 12,color: Colors.grey)),
        SizedBox(height: 5),
      ],
    );
  }
}