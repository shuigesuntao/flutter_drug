import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/dialog_image_picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  File _header;
  File _firstCard;
  File _secondCard;
  File _zgzsCard;
  File _qtzjCard;
  String _name;
  String _level;
  TextEditingController _controller = TextEditingController();
  UserModel userModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userModel = Provider.of<UserModel>(context);
    _name = userModel.user?.name ?? '';
    _level = userModel.user?.level ?? '';
  }
  @override
  Widget build(BuildContext context) {

    _controller.value = TextEditingValue(
        // 设置内容
        text: _name,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: _name.length)));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TitleBar.buildCommonAppBar(context, '资质认证'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildHeaderItem(),
              Divider(height: 1, color: Colors.grey),
              _buildNameItem(),
              Divider(height: 1, color: Colors.grey),
              _buildLevelItem(),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('上传执业证照片', style: TextStyle(fontSize: 16))),
                    GestureDetector(
                      onTap: () =>
                        Navigator.of(context).pushNamed(RouteName.example),
                      child: Text('查看示例',
                        style: TextStyle(color: Colors.red[900], fontSize: 16)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _firstCard == null
                            ? showImageDialog((file) {
                            setState(() {
                              _firstCard = file;
                            });
                          })
                            : Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) =>
                                HeroPhotoViewWrapper(
                                  imageProvider: FileImage(_firstCard),
                                  tag: 'first',
                                ),
                            ));
                        },
                        child: _buildImageItem(
                          _firstCard, 'zyzs_01.png', 'first', () {
                          setState(() {
                            _firstCard = null;
                          });
                        }))),
                    SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _secondCard == null
                            ? showImageDialog((file) {
                            setState(() {
                              _secondCard = file;
                            });
                          })
                            : Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return HeroPhotoViewWrapper(
                                  imageProvider:
                                  FileImage(_secondCard),
                                  tag: 'second',
                                );
                              }));
                        },
                        child: _buildImageItem(
                          _secondCard, 'zyzs_02.png', 'second', () {
                          setState(() {
                            _secondCard = null;
                          });
                        }))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Text('上传其他证件照片', style: TextStyle(fontSize: 16)),
                    Text('（选填）', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _zgzsCard == null
                            ? showImageDialog((file) {
                            setState(() {
                              _zgzsCard = file;
                            });
                          })
                            : Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) =>
                                HeroPhotoViewWrapper(
                                  imageProvider: FileImage(_zgzsCard),
                                  tag: 'zgzs',
                                ),
                            ));
                        },
                        child: _buildImageItem(_zgzsCard, 'zgzs.png', 'zgzs',
                            () {
                            setState(() {
                              _zgzsCard = null;
                            });
                          }))),
                    SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _qtzjCard == null
                            ? showImageDialog((file) {
                            setState(() {
                              _qtzjCard = file;
                            });
                          })
                            : Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return HeroPhotoViewWrapper(
                                  imageProvider: FileImage(_qtzjCard),
                                  tag: 'qtzj',
                                );
                              }));
                        },
                        child: _buildImageItem(_qtzjCard, 'qtzj.png', 'qtzj',
                            () {
                            setState(() {
                              _qtzjCard = null;
                            });
                          }))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('1、请确保头像以及证件上姓名、照片、编号、执业范围清晰可见；',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 3),
                    Text('2、需要上传执业证书第一页、第二页，确保执业地点及变更记录清晰可见；',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 3),
                    Text('3、上传资质信息仅用于认证，患者和第三方不可见；',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(12),
                    onPressed: () {
                      userModel.user.name = _name;
                      userModel.user.level = _level;
                      userModel.saveUser(userModel.user);
                      Navigator.maybePop(context);
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      '修改资质',
                      style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem() {
    return GestureDetector(
      onTap: () {
        showImageDialog((file) {
          setState(() {
            _header = file;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: Text('头像', style: TextStyle(fontSize: 16))),
            ClipOval(
              child: _header == null
                  ? CachedNetworkImage(
                      imageUrl: userModel.user.icon,
                      width: 45,
                      height: 45,
                      errorWidget: (context, url, error) => Image.asset(
                        ImageHelper.wrapAssets('yishengtouxiang.png'),
                        fit: BoxFit.fill,
                        width: 45,
                        height: 45,
                      ),
                    )
                  : Image.file(
                      _header,
                      width: 45,
                      height: 45,
                      fit: BoxFit.fill,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameItem() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        height: 50,
        child: Row(
          children: <Widget>[
            Text('姓名', style: TextStyle(fontSize: 16)),
            Expanded(
              child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintText: '请输入您的姓名',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: null,
                  disabledBorder: null),
              controller: _controller,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.end,
              onSubmitted: (text) {
                setState(() {
                  _name = text;
                });
              },
            )
            )
          ],
        ));
  }

  Widget _buildLevelItem() {
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                message: Text('请选择'),
                cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.maybePop(context),
                    child: Text('取消')),
                actions: _buildLevelActions(),
              )),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('职称', style: TextStyle(fontSize: 16)),
              ),
              Text(_level.isEmpty ? '请选择' : _level,
                  style: TextStyle(color: Colors.grey)),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          )),
    );
  }

  Widget _buildImageItem(
      File file, String defaultImage, String tag, VoidCallback onTap) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
            child: Hero(
                tag: tag,
                child: file == null
                    ? Image.asset(
                        ImageHelper.wrapAssets(defaultImage),
                        width: 170,
                        height: 95,
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        file,
                        width: 170,
                        height: 95,
                        fit: BoxFit.fill,
                      ))),
        Positioned(
            top: 0,
            right: 10,
            child: Offstage(
                offstage: file == null,
                child: InkWell(
                  onTap: onTap,
                  child: Image.asset(ImageHelper.wrapAssets('ic_delete.png'),
                      width: 20, height: 20),
                ))),
      ],
    );
  }

  showImageDialog(Function(File) onImageSelected) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => DialogImagePicker(
              onImageSelected: onImageSelected,
            ));
  }

  List<Widget> _buildLevelActions() {
    final List<String> levels = [
      '国医大师',
      '名中医',
      '主任医师',
      '副主任医师',
      '主治医师',
      '执业医师',
      '确有专长'
    ];
    return levels
        .map((level) => CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _level = level;
              });
              Navigator.maybePop(context);
            },
            child: Text(level)))
        .toList();
  }
}

class HeroPhotoViewWrapper extends StatelessWidget {
  const HeroPhotoViewWrapper(
      {this.imageProvider,
      this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.tag});

  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      onTapDown: (context, details, controllerValue) {
        Navigator.of(context).pop();
      },
      imageProvider: imageProvider,
      loadingChild: loadingChild,
      backgroundDecoration: backgroundDecoration,
      minScale: minScale,
      maxScale: maxScale,
      heroAttributes: PhotoViewHeroAttributes(tag: tag),
    );
  }
}
