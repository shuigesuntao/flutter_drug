import 'package:flutter/foundation.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


import 'view_state_list_model.dart';

/// 基于
abstract class ViewStateRefreshListModel<T> extends ViewStateListModel {
  /// 分页第一页页码
  static const int pageNumFirst = 0;

  /// 分页条目数量
  static const int pageSize = 20;

  EasyRefreshController _refreshController = EasyRefreshController();

  EasyRefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  /// 下拉刷新
  Future<List<T>> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      if (data.isEmpty) {
        setEmpty();
        _finishRefresh();
      } else {
        list.clear();
        list.addAll(data);
        _finishRefresh();
        if (init) {
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
      return data;
    } catch (e, s) {
      handleCatch(e, s);
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.finishLoad(noMore: true);
      } else {
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.finishLoad(noMore: true);
        } else {
          refreshController.finishLoad(noMore: false);
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.finishLoad(success:false);
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _finishRefresh() {
    refreshController.resetLoadState();
    refreshController.finishRefresh();
  }
}
