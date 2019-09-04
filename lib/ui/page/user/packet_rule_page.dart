

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PacketRulePage extends StatefulWidget{
  final String url;
  PacketRulePage({this.url});
  @override
  State<StatefulWidget> createState() => _PacketRulePageState();

}

class _PacketRulePageState extends State<PacketRulePage>{
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();
  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(
        context,
        '提现说明',
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          initialUrl: widget.url,
          // 加载js
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
            _webViewController.currentUrl().then((url) {
              debugPrint('返回当前$url');
            });
          },
          onPageFinished: (String value) async {
            debugPrint('加载完成: $value');
            if (!_finishedCompleter.isCompleted) {
              _finishedCompleter.complete(true);
            }
            refreshNavigator();
          },
        ),
      ),
    );
  }


  /// 刷新导航按钮
  ///
  /// 目前主要用来控制 '前进','后退'按钮是否可以点击
  /// 但是目前该方法没有合适的调用时机.
  /// 在[onPageFinished]中,会遗漏正在加载中的状态
  /// 在[navigationDelegate]中,会存在页面还没有加载就已经判断过了.
  void refreshNavigator() {
    /// 是否可以后退
    _webViewController.canGoBack().then((value) {
      debugPrint('canGoBack--->$value');
      return canGoBack.value = value;
    });

    /// 是否可以前进
    _webViewController.canGoForward().then((value) {
      debugPrint('canGoForward--->$value');
      return canGoForward.value = value;
    });
  }
}