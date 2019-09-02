

import 'package:flutter/material.dart';
import 'package:flutter_drug/model/decoct_method.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/view_model/decoct_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DecoctManagePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DecoctModel>(
      model: DecoctModel(),
      onModelReady: (decoctModel) {
        decoctModel.initData();
      },
      builder: (context, decoctModel, child){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Color(0xFFFAFAFA),
            elevation: 0,
            title: Text('入煎方法'),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () => print("点击了添加"),
                  child: Center(
                    child: Text(
                      '添加',
                      style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ))
            ],
          ),
          body: MediaQuery.removePadding(
            context: context,
            removeTop: false,
            child: Builder(builder: (_) {
              return SmartRefresher(
                controller: decoctModel.refreshController,
                header: ClassicHeader(),
                footer: ClassicFooter(),
                onRefresh: decoctModel.refresh,
                onLoading: decoctModel.loadMore,
                enablePullUp: true,
                child: ListView.separated(

                  itemCount: decoctModel.decoctMethods.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(
                        decoctModel.decoctMethods[index].name,
                        style: TextStyle(fontSize: 16),
                      )
                    );
                  },
                ),
              );
            })),
        );
      },
    );

  }

}