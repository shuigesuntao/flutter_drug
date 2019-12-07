import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class DialogYiZhuSelect extends StatefulWidget {
  /// 标签的list
  final List<String> dataTimeList;
  final List<String> dataJiKouList;
  /// 标签的list
  final List<String> selectTimeList;
  final List<String> selectJiKouList;

  ///确定回调事件
  final Function(String,String) onConfirm;

  DialogYiZhuSelect(this.dataTimeList,this.dataJiKouList,{this.selectTimeList,this.selectJiKouList, this.onConfirm});

  @override
  _DialogYiZhuSelectState createState() => _DialogYiZhuSelectState(selectTimeList,selectJiKouList);
}

class _DialogYiZhuSelectState extends State<DialogYiZhuSelect> {
  List<String> selectTimeList;
  List<String> selectJiKouList;

  _DialogYiZhuSelectState(this.selectTimeList,this.selectJiKouList);

  List<Widget> _buildChoiceList(List<String> data,List<String> selectList) {
    List<Widget> choices = List();
    data.forEach((item) {
      bool isChecked = selectList.contains(item);
      choices.add(
        GestureDetector(
          onTap: () => setState(() {
            if(isChecked){
              selectList.remove(item);
            }else{
              selectList.add(item);
            }
          }),
          child: Container(
            alignment: Alignment.center,
            child: Text(item, style: TextStyle(color: isChecked?Colors.white:Colors.grey[700],fontSize: 13)),
            decoration: BoxDecoration(
              border: isChecked
                ? null
                : Border.all(color: Colors.grey[600], width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
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
      color: Colors.white,
      height: ScreenUtil().setWidth(540),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Text('用药医嘱',style: TextStyle(fontSize: 15)),
                Container(
                  height: 40,
                  child: FlatButton(
                    child: Text('确定', style: TextStyle(
                      color: Theme
                        .of(context)
                        .primaryColor)),
                    onPressed: (){
                      if(selectTimeList.isEmpty && selectJiKouList.isEmpty){
                        showToast('请选择用药医嘱');
                      }else{
                        widget.onConfirm(selectTimeList.join(','),selectJiKouList.join(','));
                        Navigator.maybePop(context);
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('*用药时间',style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          Container(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //水平子Widget之间间距
              crossAxisSpacing: 15,
              //垂直子Widget之间间距
              mainAxisSpacing: 15,
              //GridView内边距
              padding: EdgeInsets.symmetric(horizontal: 20),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 3,
              //子Widget列表
              children: _buildChoiceList(widget.dataTimeList,selectTimeList)
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('*用药忌口',style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          Expanded(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              //水平子Widget之间间距
              crossAxisSpacing: 15,
              //垂直子Widget之间间距
              mainAxisSpacing: 15,
              //GridView内边距
              padding: EdgeInsets.symmetric(horizontal: 20),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 3,
              //子Widget列表
              children: _buildChoiceList(widget.dataJiKouList,selectJiKouList)
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('* 注：如有特殊用药时间和方法，请在补充医嘱内填写',style: TextStyle(fontSize: 11,color: Colors.red)),
          ),
          SizedBox(height: 40)
        ],
      )
    );
  }
}