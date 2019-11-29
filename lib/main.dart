import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/provider_manager.dart';
import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_drug/ui/widget/refresh_header.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'config/router_manager.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
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
        child: RefreshConfiguration(
          headerBuilder: ()=> RefreshHeader(),
          footerBuilder: ()=> ClassicFooter(
            noDataText: '已经全部加载完毕',
            idleText:'上拉可以加载更多',
            canLoadingText:'松开立即加载更多',
            loadingText:'正在加载更多的数据...',
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '药匣子',
          theme: ThemeData(
            primaryColor: Color(0xffd80c18),
            scaffoldBackgroundColor: Color(0xffeeeeed),
            primaryIconTheme: IconThemeData(color: Colors.white),
            appBarTheme: AppBarTheme(elevation: 0,brightness:Brightness.light)
          ),
          onGenerateRoute: Router.generateRoute,
          initialRoute: RouteName.splash,
        )
        ),
      )
    );

  }
}
