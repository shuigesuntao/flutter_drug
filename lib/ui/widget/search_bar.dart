
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
  }): super(key: key);

  final Color backgroundColor;
  final String hintText;
  final Function(String) onPressed;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(48.0);
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
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 6.0, left: -8.0, right: -16.0, bottom: 6.0),
                        border: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(ImageHelper.wrapAssets('edit_search.png')),
                        ),
                        hintText: widget.hintText,
                        hintStyle:TextStyle(fontSize: 14,color: Color(0xFFcccccc))
                      ),
                      onSubmitted: (text){
                        widget.onPressed(text);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    Navigator.maybePop(context);
                  },
                  child: Center(
                    child: Text('取消',style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}