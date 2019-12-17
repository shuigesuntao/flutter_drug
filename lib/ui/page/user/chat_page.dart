import 'package:flutter/material.dart';
import 'package:flutter_drug/config/net/api.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/model/friend.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  final Friend friend;

  ChatPage({this.friend});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _expand = false;
  bool _isShow = true;
  bool _isVoice = false;
  bool _canSend = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isShow = !_focusNode.hasFocus;
        _expand = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        appBar: TitleBar.buildCommonAppBar(
          context, '与${widget.friend.displayName}的对话', actionText: '查看档案',
          onActionPress: () {
            Navigator.of(context)
              .pushNamed(RouteName.friendInfo, arguments: widget.friend);
          }),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Color(0xffe6e6e6),
                child:ListView.builder(
                  itemBuilder: (context, index) => _buildMessageItem(),
                  itemCount: 0,
                ),
              )),
            Offstage(
              offstage: !_isShow,
              child: Container(
                color: Color(0xfff5f5f5),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child:
                          _buildKeyBoardActionItem('icon_ftp.png', '发图片', () {
                            print('发图片');
                          })),
                        Expanded(
                          child: _buildKeyBoardActionItem(
                            'icon_zxkf_chat.png', '在线开方', () {
                            print('在线开方');
                          })),
                        Expanded(
                          child: _buildKeyBoardActionItem('icon_jswz.png', '结束咨询',
                              () {
                              print('结束咨询');
                            })),
                        Expanded(
                          child: _buildKeyBoardActionItem(
                            _expand ? 'icon_sq.png' : 'icon_zk.png',
                            _expand ? '收起' : '展开', () {
                            setState(() {
                              _expand = !_expand;
                            });
                          })),
                      ],
                    ),
                    Offstage(
                      offstage: !_expand,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: _buildKeyBoardActionItem('icon_fwzd.png', '发问诊单',
                                () {
                                print('发问诊单');
                              }),
                          ),
                          Expanded(
                            child: _buildKeyBoardActionItem(
                              'icon_txwsda.png', '提醒完善档案', () {
                              print('提醒完善档案');
                            }),
                          ),
                          Expanded(
                            child: _buildKeyBoardActionItem('icon_pzsc.png', '拍方上传',
                                () {
                                print('拍方上传');
                              }),
                          ),
                          Expanded(
                            child: _buildKeyBoardActionItem('icon_kjhf.png', '快捷回复',
                                () {
                                print('快捷回复');
                              }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0.5, color: Colors.grey[400]),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                color: Color(0xfff5f5f5),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _isVoice=!_isVoice;
                        });
                      },
                      child: Image.asset(ImageHelper.wrapAssets(_isVoice?'btn_keyboard.png':'btn_voices.png'),width: ScreenUtil().setWidth(30),height:  ScreenUtil().setWidth(30)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          height: ScreenUtil().setWidth(35),
                          child: _isVoice ? GestureDetector(
                            onLongPressEnd: (LongPressEndDetails details){
                              print('结束录音...');
                            },
                            onLongPress: () {
                              print('正在录音...');
                            },

                            child: Text('按住 说话',textAlign: TextAlign.center,style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                          ):TextField(
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.send,
                            focusNode: _focusNode,
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left:ScreenUtil().setWidth(10),bottom: ScreenUtil().setWidth(10)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '在这里输入',
                              hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
                              border: InputBorder.none
                            ),
                            onChanged: (text){
                              setState(() {
                                _canSend = text.isNotEmpty;
                              });
                            },
                            style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                      height: ScreenUtil().setWidth(35),
                      decoration: BoxDecoration(
                        color: !_canSend ? Colors.grey :Color(0xffe56068),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text('发送',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14))),
                    )
                  ],
                ),
              ),
              bottom: true,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem() {
    return Container();
  }

  Widget _buildKeyBoardActionItem(
      String icon, String label, VoidCallback onTap) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
          child: Column(
            children: <Widget>[
              Image.asset(ImageHelper.wrapAssets(icon),
                  width: ScreenUtil().setWidth(25),
                  height: ScreenUtil().setWidth(25)),
              SizedBox(height: ScreenUtil().setWidth(5)),
              Text(label, style: TextStyle(fontSize: ScreenUtil().setSp(13)))
            ],
          ),
        ),
      ),
    );
  }
}
