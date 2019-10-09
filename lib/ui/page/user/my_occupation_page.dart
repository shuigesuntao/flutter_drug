import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

import 'insurance_page.dart';
import 'law_help_page.dart';

class MyOccupationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyOccupationPageState();
}

class MyOccupationPageState extends State<MyOccupationPage> {
  var _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                padding: EdgeInsets.all(0),
                child: new IconButton(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  icon: Image.asset(
                    ImageHelper.wrapAssets('ic_back_black.png'),
                    fit: BoxFit.contain,
                    width: 16,
                    height: 16,
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
            ],
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildButton(0, '执业保险'),
              _buildButton(1, '法律援助')
            ],
          )),
      body: PageView.builder(
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
    );
  }

  _animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: ElasticOutCurve(4));
  }

  Widget _buildButton(int index, String text) {
    return GestureDetector(
      onTap: () => _animateToPage(index),
      child: Container(
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).primaryColor
                : Colors.white,
            border: Border.all(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.only(
                topLeft: index == 0 ? Radius.circular(5) : Radius.circular(0),
                topRight: index == 1 ? Radius.circular(5) : Radius.circular(0),
                bottomLeft: index == 0 ? Radius.circular(5) : Radius.circular(0),
                bottomRight: index == 1 ? Radius.circular(5) : Radius.circular(0)),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                color: _selectedIndex == index
                    ? Colors.white
                    : Theme.of(context).primaryColor),
          )),
    );
  }
}

List<Widget> pages = <Widget>[
  InsurancePage(),
  LawHelpPage(),
];
