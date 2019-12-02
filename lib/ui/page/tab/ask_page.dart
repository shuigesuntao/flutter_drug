import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/conversation.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/conversation_model.dart';

class AskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: TitleBar.buildCommonAppBar(context, '咨询',isShowBack: false),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10,5,10,5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('待随访',style: TextStyle(fontSize: 16)),
                              Text('共 0 人',style: TextStyle(color: Colors.grey)),
                            ]
                          ),
                          Image.asset(ImageHelper.wrapAssets('icon_daisuifagn.png'),width: 30,height: 30)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child:  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10,5,10,5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('待复诊',style: TextStyle(fontSize: 16)),
                              Text('共 0 人',style: TextStyle(color: Colors.grey)),
                            ]
                          ),
                          Image.asset(ImageHelper.wrapAssets('icon_daifuzhen.png'),width: 30,height: 30)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          Expanded(child: ProviderWidget<ConversationModel>(
            model: ConversationModel(),
            onModelReady: (conversationModel) => conversationModel.initData(),
            builder: (context, conversationModel, child) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                  _buildConversationItem(conversationModel.list[index]),
                itemCount: conversationModel.list?.length??0,
              );
            }))
        ],
      ),
    );
  }
  _buildConversationItem(Conversation conversation) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: conversation.headerUrl,
                  errorWidget: (context, url, error) => conversation.gender == "男"
                    ? Image.asset(ImageHelper.wrapAssets('gender_boy.png'),
                    width: 45, height: 45)
                    : Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
                    width: 45, height: 45),
                  fit: BoxFit.fill,
                  width: 45,
                  height: 45,
                ),
              ),
              Expanded(child: Padding(padding: EdgeInsets.only(left: 10),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    conversation.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    conversation.message,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),)),
              Container(
                height: 40,
                alignment: Alignment.topRight,
                child:  Text(
                  conversation.time,
                  style: TextStyle(fontSize: 12,color: Colors.grey)
                ),
              )
            ],
          )
        ),
        Divider(height: 1)
      ],
    );
  }
}
