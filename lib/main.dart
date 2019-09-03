import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'config/router_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFF25bbaf),
          scaffoldBackgroundColor: Color(0xFFF2F2F2),
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(elevation: 0)
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: RouteName.splash,
      )
    );
  }
}
