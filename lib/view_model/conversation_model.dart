
import 'package:flutter_drug/model/conversation.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';

class ConversationModel extends ViewStateListModel<Conversation>{

  @override
  Future<List<Conversation>> loadData() async{
    List<Conversation> results = List();
    results.add(Conversation("李达康","男","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593337718937&di=47607ada09f722c128fef128b76381f9&imgtype=0&src=http%3A%2F%2Fcrawler-fs.intsig.net%2Fcamfs%2Fdownload%3Ffilename%3D10005_603c002d2ec90850c339529b9a11eec2_9.jpeg","[问诊已结束]","12:30"));
    results.add(Conversation("杨过","男","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3591849528,3749372701&fm=26&gp=0.jpg","吃了头孢可少喝点酒","昨天"));
    results.add(Conversation("小龙女","女","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2343523762,337482317&fm=26&gp=0.jpg","有什么问题？","2020/05/10"));
    results.add(Conversation("张飞","男","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593337815954&di=ddc85172d74958d950d602e370421466&imgtype=0&src=http%3A%2F%2Fstatic.1sapp.com%2Fqupost%2Fimage%2Fsp%2F2018%2F07%2F07%2F1530898409618.jpeg","先做个核酸检测，看报告再聊","2020/05/09"));
    results.add(Conversation("尹志平","男","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593337601012&di=e1fbca9d29c8dbe34f59396435f3aee9&imgtype=0&src=http%3A%2F%2Fdingyue.nosdn.127.net%2Fkbb0rMEMK2CWNqFMMQAw2R2GEGP446tYN8H1DnwarB0ng1528724852331.jpg","忌辛辣，牛羊肉","2020/05/09"));
    results.add(Conversation("小燕子","女","https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1303824612,1664848010&fm=26&gp=0.jpg","[建议方]","2019/10/09"));
    return results;
  }


}