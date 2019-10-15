import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MultiNormalSelectChip extends StatefulWidget {
  /// 标签的list
  final List<String> dataList;

  /// 标签的list
  final List<String> selectList;

  final String title;
  final double height;
  final bool isSingle;

  ///确定回调事件
  final Function(String) onConfirm;

  MultiNormalSelectChip(this.dataList,{this.title='',this.isSingle=false,this.selectList,this.height, this.onConfirm});

  @override
  _MultiNormalSelectChipState createState() => _MultiNormalSelectChipState(selectList);
}

class _MultiNormalSelectChipState extends State<MultiNormalSelectChip> {
  List<String> selectList;

  _MultiNormalSelectChipState(this.selectList);

  List<Widget> _buildChoiceList() {
    List<Widget> choices = List();
    widget.dataList.forEach((item) {
      bool isChecked = selectList.contains(item);
      choices.add(
        GestureDetector(
          onTap: () => setState(() {
            if(selectList.contains(item) && !widget.isSingle){
              selectList.remove(item);
            }else{
              if(widget.isSingle){
                selectList.clear();
              }
              selectList.add(item);
            }
          }),
          child: Container(
            alignment: Alignment.center,
            child: Text(item, style: TextStyle(color: isChecked?Colors.white:Colors.grey)),
            decoration: BoxDecoration(
              border: isChecked
                ? null
                : Border.all(color: Colors.grey[600], width: 1),
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: isChecked
                ? Theme.of(context).primaryColor
                : Colors.white),
          )
        )
      );
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40,
                  child: FlatButton(
                    child: Text('取消', style: TextStyle(
                      color: Colors.grey[700])),
                    onPressed: () => Navigator.maybePop(context)
                  ),
                ),
                Text(widget.title),
                Container(
                  height: 40,
                  child: FlatButton(
                    child: Text('确定', style: TextStyle(
                      color: Theme
                        .of(context)
                        .primaryColor)),
                    onPressed: (){
                      if(selectList.isEmpty){
                        showToast('请选择膏方辅料!');
                      }else{
                        widget.onConfirm(selectList.join(','));
                        Navigator.maybePop(context);
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              //水平子Widget之间间距
              crossAxisSpacing: 20,
              //垂直子Widget之间间距
              mainAxisSpacing: 15,
              //GridView内边距
              padding: EdgeInsets.all(20),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 3,
              //子Widget列表
              children: _buildChoiceList()
            )
          ),
        ],
      ),
    );
  }
}