
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drug/config/resource_mananger.dart';


class SearchBar extends StatefulWidget implements PreferredSizeWidget{

  const SearchBar({
    Key key,
    this.backgroundColor: Colors.white,
    this.hintText: "",
    this.onPressed,
    this.isCancel = true,
    this.onChanged
  }): super(key: key);

  final Color backgroundColor;
  final String hintText;
  final Function(String) onPressed;
  final bool isCancel;
  final Function(String) onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}

class _SearchBarState extends State<SearchBar> {

  SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light;
  TextEditingController _controller = TextEditingController();

  Color getColor(){
    return overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    overlayStyle = ThemeData.estimateBrightnessForColor(widget.backgroundColor) == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: widget.backgroundColor,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            color: widget.backgroundColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(-15,10,10,9),
                        border: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(15,5,15,5),
                          child: Image.asset(ImageHelper.wrapAssets('edit_search.png'),width: 18,height: 18),
                        ),
                        hintText: widget.hintText,
                        hintStyle:TextStyle(fontSize: 16,color: Colors.grey[350])
                      ),
                      onSubmitted: (text){
                        widget.onPressed(text);
                      },
                      onChanged: (text){
                        if(widget.onChanged!= null){
                          widget.onChanged(text);
                        }
                      },
                    ),
                  ),
                ),
                widget.isCancel?Padding(
                  padding: EdgeInsets.only(left: 15),
                  child:  GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    Navigator.maybePop(context);
                  },
                  child: Center(
                    child: Text('取消',style: TextStyle(color: Colors.grey,fontSize: 16)),
                  ),
                )
                ):Container()
              ],
            )
          ),
        ),
      ),
    );
  }
}