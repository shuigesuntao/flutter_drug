import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/bill.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/dialog_progress.dart';
import 'package:flutter_drug/ui/widget/picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/bill_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShowAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '查看账单'),
      body: ProviderWidget<BillModel>(
        model: BillModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => showPicker(context),
                          child: Text('${formatDate()}',
                              style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Image.asset(
                            ImageHelper.wrapAssets('icon_qiehuan.png'),
                            width: ScreenUtil().setWidth(12),
                            height: ScreenUtil().setWidth(12))
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setWidth(5)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.monthBill),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                  '收入￥${model.totalIn} 支出￥${model.totalOut}',
                                  style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)))),
                          Text('月账单', style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14))),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(child: model.isBusy
                ? Center(child: ProgressDialog())
                : model.isError
                ? ViewStateWidget(onPressed: model.initData)
                : SmartRefresher(
                controller: model.refreshController,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                enablePullUp: !model.isEmpty,
                child: model.isEmpty
                  ? ViewStateEmptyWidget()
                  : ListView.builder(
                  itemCount: model.list.length,
                  itemBuilder: (context, index) {
                    return _buildBillItem(context, model.list[index]);
                  }
                )
              ))
            ],
          );
        },
      ),
    );
  }

  Widget _buildBillItem(BuildContext context,Bill bill){
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child: Row(
              children: <Widget>[
                Image.asset(ImageHelper.wrapAssets(bill.type==1?'ic_shou.png':'ic_zhi.png'),width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32)),
                SizedBox(width: ScreenUtil().setWidth(15)),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(bill.name,style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                    SizedBox(height: ScreenUtil().setWidth(5)),
                    Text(bill.time,style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(13)))
                  ],
                )),
                Text(bill.type==1?'+${bill.price}':'-${bill.price}',style: TextStyle(fontSize:ScreenUtil().setSp(18),fontWeight:FontWeight.w500,color: bill.type==1?Theme.of(context).primaryColor:Colors.red))
              ],
            ),
          ),
          Divider(indent: ScreenUtil().setWidth(65),color: Colors.grey[400],height: 0.5,)
        ],
      )
    );
  }

  String formatDate() {
    String now = DateTime.now().toString();
    return '${now.substring(0, 4)}年${now.substring(5, 7)}月';
  }

  showPicker(BuildContext context) {
    Picker(
        columnFlex: [1, 1],
        adapter: DateTimePickerAdapter(
            type: 11, yearSuffix: "年", monthSuffix: "月", isNumberMonth: true),
        delimiter: [
          PickerDelimiter(
              child: VerticalDivider(
            width: 1,
            color: Colors.grey[300],
          ))
        ],
        title: '',
        itemExtent: 40,
        selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        columnPadding: const EdgeInsets.all(15),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).getText());
        }).showModal(context);
  }
}
