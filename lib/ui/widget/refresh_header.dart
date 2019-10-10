import 'package:flutter/material.dart' hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends RefreshIndicator{
  RefreshHeader() : super(height: 80.0, refreshStyle: RefreshStyle.Follow);
  @override
  State<StatefulWidget> createState() => _RefreshHeaderState();
}

class _RefreshHeaderState extends RefreshIndicatorState<RefreshHeader> with SingleTickerProviderStateMixin{
  GifController _gifController;
  String _tip = '下拉刷新';

  @override
  void initState() {
    _gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  void onModeChange(RefreshStatus mode) {
    _gifController.repeat(min: 0, max: 9, period: Duration(milliseconds: 1000));
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
  Future<void> endRefresh() {
    _gifController.value = 9;
    return _gifController.animateTo(9, duration: Duration(milliseconds: 1000));
  }

  @override
  void resetValue() {
    _gifController.value = 0;
    super.resetValue();
  }


  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        GifImage(
          image: AssetImage(ImageHelper.wrapAssets('lodigngif.gif')),
          controller: _gifController,
          height: 70,
        ),
        Column(
          children: <Widget>[
            Text('小匣子 大国医',style: TextStyle(color: Theme.of(context).primaryColor)),
            Text(_tip,style: TextStyle(fontSize: 12,color: Colors.grey)),
            SizedBox(height: 10)
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
}