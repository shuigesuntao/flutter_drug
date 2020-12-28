import 'package:cool_ui/cool_ui.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/provider_manager.dart';
import 'package:flutter_drug/config/storage_manager.dart';
import 'package:flutter_drug/ui/widget/custom_edit_drug_keyboard.dart';
import 'package:flutter_drug/ui/widget/custom_letter_keyboard.dart';
import 'package:flutter_drug/ui/widget/custom_number_keyboard.dart';
import 'package:flutter_drug/ui/widget/refresh_footer.dart';
import 'package:flutter_drug/ui/widget/refresh_header.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart' as P;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'config/router_manager.dart';
import 'event/event_bus.dart';

void main() async {
  P.Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  CustomNumberKeyBoard.register();
  CustomLetterKeyboard.register();
  CustomEditDrugBoard.register();
  runApp(KeyboardRootWidget(child:App()));
  RongIMClient.init('aaa');
  // Android状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class App extends StatelessWidget {

  App(){
    final eventBus = new EventBus();
    ApplicationEvent.event = eventBus;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: P.MultiProvider(
        providers: providers,
        child: RefreshConfiguration(
          headerBuilder: ()=> RefreshHeader(),
          footerBuilder: ()=> RefreshFooter(),
          hideFooterWhenNotFull: true,
          child: MaterialApp(
          debugShowCheckedModeBanner:false,
          title: '药良心',
          theme: ThemeData(
            primaryColor: Color(0xffd80c18),
            scaffoldBackgroundColor: Color(0xffeeeeed),
            primaryIconTheme: IconThemeData(color: Colors.white),
            appBarTheme: AppBarTheme(elevation: 0,brightness:Brightness.light)
          ),
          onGenerateRoute: Routers.generateRoute,
          initialRoute: RouteName.splash,
        )
        ),
      )
    );

  }
}
