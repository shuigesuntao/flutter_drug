import 'package:flutter/material.dart' hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshFooter extends LoadIndicator{
  RefreshFooter() : super(height: 60.0, loadStyle: LoadStyle.ShowWhenLoading);
  @override
  State<StatefulWidget> createState() => _RefreshFooterState();
}

class _RefreshFooterState extends LoadIndicatorState<RefreshFooter> with SingleTickerProviderStateMixin{
  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Center(
        child: Wrap(
          spacing: 10,
          textDirection: TextDirection.ltr,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          verticalDirection: VerticalDirection.down,
          alignment: WrapAlignment.center,
          children: <Widget>[
            mode == LoadStatus.noMore || mode == LoadStatus.failed?SizedBox():Image.asset(ImageHelper.wrapAssets('lodigngif.gif'),width: 25,height: 25),
            Text(mode == LoadStatus.loading?'正在加载...': mode == LoadStatus.noMore?'已经全部加载完毕':mode == LoadStatus.failed?'加载失败':mode == LoadStatus.canLoading ?'释放立即加载':'上拉加载更多'),
          ],
      ),
    ));
  }

}