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
        fixedColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageHelper.wrapAssets('ic_home.png')), size: 25),
            title: Text(
              '工作室',
              style: TextStyle(fontSize: 12)
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageHelper.wrapAssets('ic_talk.png')), size: 25),
            title: Text(
              '资询',
              style: TextStyle(fontSize: 12)
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageHelper.wrapAssets('ic_address_book.png')), size: 25),
            title: Text(
              '通讯录',
              style: TextStyle(fontSize: 12)
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageHelper.wrapAssets('ic_me.png')), size: 25),
            title: Text(
              '我的',
              style: TextStyle(fontSize: 12)
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
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
