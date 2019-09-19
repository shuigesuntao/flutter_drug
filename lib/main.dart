import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/provider_manager.dart';
import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_drug/config/ui_adapter_config.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'config/router_config.dart';

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

  @override
  Widget build(BuildContext context) {
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

  }
}
