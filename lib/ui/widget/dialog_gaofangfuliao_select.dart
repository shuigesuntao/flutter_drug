import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class DialogGaoFangFuLiaoSelect extends StatefulWidget {
  /// 标签的list
  final List<String> dataList;

  /// 标签的list
  final List<String> selectList;

  final double height;

  ///确定回调事件
  final Function(String) onConfirm;

  DialogGaoFangFuLiaoSelect(this.dataList,{this.selectList,this.height, this.onConfirm});

  @override
  _DialogGaoFangFuLiaoSelectState createState() => _DialogGaoFangFuLiaoSelectState(selectList);
}

class _DialogGaoFangFuLiaoSelectState extends State<DialogGaoFangFuLiaoSelect> {
  List<String> selectList;

  _DialogGaoFangFuLiaoSelectState(this.selectList);

  List<Widget> _buildChoiceList() {
    List<Widget> choices = List();
    widget.dataList.forEach((item) {
      bool isChecked = selectList.contains(item);
      choices.add(
        GestureDetector(
          onTap: () => setState(() {
            selectList.clear();
            selectList.add(item);
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
                Text('膏方辅料选择'),
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