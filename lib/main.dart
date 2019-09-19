import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/provider_manager.dart';
import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_drug/config/ui_adapter_config.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'config/router_config.dart';
import 'ui/page/splash.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  InnerWidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  /// 全局屏幕适配方案
  runApp(App());
  // Android状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class App extends StatelessWidget {
  /// 在App运行之前,需要初始化的异步操作
  /// 如果存在多个,可以使用[Future.wait(futures)]来合并future后传入
  final Future future;

  const App({this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot){
        /// 在异步操作时,显示的页面
        if (snapshot.connectionState != ConnectionState.done) {
          return SplashImage();
        }
        return OKToast(
          child: MultiProvider(
            providers: providers,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: '药匣子',
              theme: ThemeData(
                primaryColor: Color(0xFF25bbaf),
                scaffoldBackgroundColor: Color(0xFFF2F2F2),
                primaryIconTheme: IconThemeData(color: Colors.white),
                appBarTheme: AppBarTheme(elevation: 0)
              ),
              onGenerateRoute: Router.generateRoute,
              initialRoute: RouteName.splash,
            ),
          )
        );
      },
    );

  }
}
