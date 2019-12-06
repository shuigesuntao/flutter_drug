import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';
import 'package:flutter_drug/config/router_manager.dart';
import 'package:flutter_drug/ui/widget/dialog_image_picker.dart';
import 'package:flutter_drug/ui/widget/titlebar.dart';
import 'package:flutter_drug/view_model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              SizedBox(height: ScreenUtil().setWidth(5)),
              _buildHeaderItem(),
              Divider(height: 0.5, color: Colors.grey[400]),
              _buildNameItem(),
              Divider(height: 0.5, color: Colors.grey[400]),
              _buildLevelItem(),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text('上传医师执业证书证照片',
                                    style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(RouteName.example),
                              child: Text('查看示例',
                                  style: TextStyle(
                                      color: Colors.red[900], fontSize: ScreenUtil().setSp(14))),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        color: Colors.grey[400],
                        height: 0.5,
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
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
                                              imageProvider:
                                                  FileImage(_firstCard),
                                              tag: 'first',
                                            ),
                                          ));
                                },
                                child: _buildImageItem(
                                    _firstCard, 'zyzs_01.png', 'first', () {
                                  setState(() {
                                    _firstCard = null;
                                  });
                                })),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            GestureDetector(
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
                                }))
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                        width: double.infinity,
                        child: Text('上传其他证件照片（选填）',style: TextStyle(fontSize: ScreenUtil().setSp(14))),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        color: Colors.grey[400],
                        height: 0.5,
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
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
                                              imageProvider:
                                                  FileImage(_zgzsCard),
                                              tag: 'zgzs',
                                            ),
                                          ));
                                },
                                child: _buildImageItem(
                                    _zgzsCard, 'zgzs.png', 'zgzs', () {
                                  setState(() {
                                    _zgzsCard = null;
                                  });
                                })),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            GestureDetector(
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
                                                  imageProvider:
                                                      FileImage(_qtzjCard),
                                                  tag: 'qtzj',
                                                );
                                              }));
                                },
                                child: _buildImageItem(
                                    _qtzjCard, 'qtzj.png', 'qtzj', () {
                                  setState(() {
                                    _qtzjCard = null;
                                  });
                                }))
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setWidth(10), ScreenUtil().setWidth(15), ScreenUtil().setWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('1、请确保头像以及证件上姓名、照片、编号、执业范围清晰可见；',
                        style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.grey)),
                    SizedBox(height: ScreenUtil().setWidth(3)),
                    Text('2、需要上传执业证书第一页、第二页，确保执业地点及变更记录清晰可见；',
                        style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.grey)),
                    SizedBox(height: ScreenUtil().setWidth(3)),
                    Text('3、上传资质信息仅用于认证，患者和第三方不可见；',
                        style: TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.grey)),
                  ],
                ),
              ),
              SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      userModel.user.name = _name;
                      userModel.user.level = _level;
                      userModel.saveUser(userModel.user);
                      Navigator.maybePop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '修改资质',
                          style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(14)),
                        )),
                  ),
                  bottom: true),
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
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
        height: ScreenUtil().setWidth(55),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: Text('头像', style: TextStyle(fontSize: ScreenUtil().setSp(14)))),
            ClipOval(
              child: _header == null
                  ? CachedNetworkImage(
                      imageUrl: userModel.user.icon,
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setWidth(40),
                      errorWidget: (context, url, error) => Image.asset(
                        ImageHelper.wrapAssets('yishengtouxiang.png'),
                        fit: BoxFit.fill,
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setWidth(40),
                      ),
                    )
                  : Image.file(
                      _header,
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setWidth(40),
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),
                width: 8, height: 16)
          ],
        ),
      ),
    );
  }

  Widget _buildNameItem() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
        color: Colors.white,
        height: ScreenUtil().setWidth(45),
        child: Row(
          children: <Widget>[
            Text('姓名', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintText: '请输入您的姓名',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(14))),
              controller: _controller,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              style: TextStyle(fontSize: ScreenUtil().setSp(14), color: Colors.grey[600]),
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
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          height: ScreenUtil().setWidth(45),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('职称', style: TextStyle(fontSize: ScreenUtil().setSp(14))),
              ),
              Text(_level.isEmpty ? '请选择' : _level,
                  style: TextStyle(color: Colors.grey[600],fontSize: ScreenUtil().setSp(14))),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Image.asset(ImageHelper.wrapAssets('youjiantou_new2x.png'),
                  width: 8, height: 16)
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
                        width: ScreenUtil().setWidth(90),
                        height: ScreenUtil().setWidth(90),
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        file,
                        width: ScreenUtil().setWidth(90),
                        height: ScreenUtil().setWidth(90),
                        fit: BoxFit.fill,
                      ))),
        Positioned(
            top: 0,
            right: 0,
            child: Offstage(
                offstage: file == null,
                child: InkWell(
                  onTap: onTap,
                  child: Image.asset(ImageHelper.wrapAssets('icon_delete.png'),
                      width: ScreenUtil().setWidth(20), height: ScreenUtil().setWidth(20)),
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
