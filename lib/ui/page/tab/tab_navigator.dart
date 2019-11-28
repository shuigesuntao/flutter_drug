import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/ui/page/tab/address_book_page.dart';
import 'package:flutter_drug/ui/page/tab/ask_page.dart';
import 'package:flutter_drug/ui/page/tab/home_page.dart';
import 'package:flutter_drug/ui/page/tab/my_page.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem('工作室','icon_home_disselect.png','icon_home_select.png'),
          _buildBottomNavigationBarItem('资询','icon_talk_disselect.png','icon_talk_select.png'),
          _buildBottomNavigationBarItem('通讯录','icon_family_disselect.png','icon_family_select.png'),
          _buildBottomNavigationBarItem('我的','icon_me_disselect.png','icon_me_select.png'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }


  BottomNavigationBarItem _buildBottomNavigationBarItem(String text,String icon,String activeIcon){
    return BottomNavigationBarItem(
      icon: Image.asset(ImageHelper.wrapAssets(icon),width: 24,height: 24),
      activeIcon: Image.asset(ImageHelper.wrapAssets(activeIcon),width: 24,height: 24),
      title: Text(
        text,
        style: TextStyle(fontSize: 12)
      ),
    );
  }
}

List<Widget> pages = <Widget>[
  HomePage(),
  AskPage(),
  AddressBookPage(),
  MyPage(),
];
