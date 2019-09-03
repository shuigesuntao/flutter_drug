import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/model/conversation.dart';
import 'package:flutter_drug/provider/provider_widget.dart';
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
      appBar: AppBar(
        title: Text('患者咨询'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Divider(height: 1),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Text('0',style: TextStyle(fontSize: 16,color: Colors.black),), Padding(padding: EdgeInsets.only(top: 5),child: Text('待随访'),)],
                  ),
                ),
                Container(width: 1, height: 25, color: Colors.grey),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Text('0',style: TextStyle(fontSize: 16,color: Colors.black)),Padding(padding: EdgeInsets.only(top: 5),child: Text('待复诊'),)],
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 10,),
          Expanded(child: ProviderWidget<ConversationModel>(
            model: ConversationModel(),
            onModelReady: (conversationModel) => conversationModel.initData(),
            builder: (context, conversationModel, child) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                  _buildConversationItem(conversationModel.conversations[index]),
                itemCount: conversationModel.conversations?.length??0,
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
                    width: 50, height: 50)
                    : Image.asset(ImageHelper.wrapAssets('gender_gril.png'),
                    width: 50, height: 50),
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50,
                ),
              ),
              Expanded(child: Padding(padding: EdgeInsets.only(left: 10),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    conversation.name,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
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
