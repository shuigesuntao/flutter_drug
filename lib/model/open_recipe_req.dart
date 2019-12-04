import 'package:flutter_drug/model/drug.dart';

class OpenRecipeReq{
  String name;
  int age;
  String phone;
  String gender;
  String bianzheng;//辩证
  String zhusu;//主诉
  int category;//类型
  int drugstore;//药房
  List<Drug> drugs;
  int jishu;
  int daishu;
  int haoshengshu;
  String gaofangfuliao;
  int way;//服药方式 1 内服 2 外用
  int drugDesc;//用药医嘱
  int extraDesc;//补充医嘱
  int fuzhenDay;//复诊时间
  int suifangDay;//随访时间
  int zhenfei;//诊费
  int singleServicePrice;//单次处方服务费
  int show;//1 可见 2不可见

  OpenRecipeReq({this.name,this.age,this.phone,this.gender,this.bianzheng,this.category,this.drugstore,this.jishu,
  this.daishu, this.haoshengshu, this.gaofangfuliao,this.way,this.drugDesc,this.extraDesc,this.fuzhenDay,this.suifangDay,this.zhenfei,this.singleServicePrice,this.show,this.drugs});
}