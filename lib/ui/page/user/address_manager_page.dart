import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/address.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/provider/view_state_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/address_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressManagePage extends StatefulWidget {

  final bool isSelect;

  AddressManagePage({this.isSelect});

  @override
  State<StatefulWidget> createState() => _AddressManagePageState();

}

class _AddressManagePageState extends State<AddressManagePage>{

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '地址管理',
        actionText: '添加新地址',
        onActionPress: () => Navigator.of(context)
          .pushNamed(RouteName.editAddress, arguments: null)),
      body: ProviderWidget<AddressModel>(
        model: AddressModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          return SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setWidth(40),
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15),ScreenUtil().setWidth(5),ScreenUtil().setWidth(15),ScreenUtil().setWidth(5)),
                          decoration: BoxDecoration(
                            color: Color(0xffeeeeed),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextField(
                            controller: _controller,
                            maxLines: 1,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(-ScreenUtil().setWidth(20), ScreenUtil().setWidth(5), ScreenUtil().setWidth(10), ScreenUtil().setWidth(5)),
                              border: InputBorder.none,
                              icon: Padding(
                                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(5), ScreenUtil().setWidth(15), ScreenUtil().setWidth(5)),
                                child: Image.asset(
                                  ImageHelper.wrapAssets('icon_sousuo.png'),
                                  width: ScreenUtil().setWidth(14),
                                  height: ScreenUtil().setWidth(14)),
                              ),
                              hintText: '请输入姓名或手机号查询',
                              hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14), color: Colors.grey[350])),
                            onSubmitted: (text) {
                              if (text.isEmpty) {
                                showToast('请输入搜索内容');
                              } else {
                                print("搜索$text");
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setWidth(10)),
                    ],
                  ),
                ),
                model.isBusy
                ? SliverToBoxAdapter(child: Container(height:ScreenUtil().setWidth(400),alignment:Alignment.center,child: CircularProgressIndicator()))
                  : model.isError
                ? ViewStateWidget(onPressed: model.initData)
                  : model.isEmpty
                ? ViewStateEmptyWidget(image: 'zwshdz.png',)
                  : SliverList(delegate: SliverChildBuilderDelegate((context,index) => _buildAddressItem(context, model.list[index]),childCount: model.list.length)
                )
              ]
            )
          );
        },
      ),
    );
  }

  Widget _buildAddressItem(BuildContext context, Address address) {
    return GestureDetector(
      onTap: (){
        if(widget.isSelect){
          Navigator.of(context).pop(address);
        }
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
              child: Container(
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setWidth(40),
                decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                child: Center(
                  child: Text(address.name.substring(0, 1),
                    style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(address.name, style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Text(address.phone,
                          style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(13)))
                      ]),
                    SizedBox(height: ScreenUtil().setWidth(3)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Offstage(
                          offstage: address.isDefault != 1,
                          child: Container(
                            margin: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                            decoration: BoxDecoration(
                              color: Color(0xffda384a),
                              borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              '默认',
                              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(12)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text('${address.area}--${address.address}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(13))))
                      ],
                    )
                  ],
                ),
              )),
            Container(
              color: Colors.grey[300],
              width: 1,
              height: ScreenUtil().setWidth(25),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                .pushNamed(RouteName.editAddress, arguments: address),
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                child: Text('编辑',
                  style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(12))),
              ),
            )
          ],
        )),
    );
  }
}
