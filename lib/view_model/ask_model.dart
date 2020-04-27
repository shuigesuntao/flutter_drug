import 'package:flutter_drug/model/ask.dart';
import 'package:flutter_drug/provider/view_state_list_model.dart';

class AskModel extends ViewStateListModel<Ask>{
  @override
  Future<List<Ask>> loadData() async {
    return await Future.delayed(Duration(seconds: 1), () {
      List<Ask> results = List();
      results.add(Ask("儿童通用问诊单",1,[
        Question("孩子的精神状态与同龄孩子相比如何？","radio", [
          Option("A","精神状况良好"),
          Option("B","精神一般"),
          Option("C","精神萎靡")
        ]),
        Question("孩子的体温情况如何？","radio", [
          Option("A","体温正常"),
          Option("B","高热（39度以上）"),
          Option("C","发热"),
          Option("D","怕冷")
        ]),
        Question("孩子的出汗情况如何？","checkbox", [
          Option("A","正常"),
          Option("B","一直不出汗"),
          Option("C","白天或活动后出汗明显"),
          Option("D","睡眠中出汗明显")
        ]),
        Question("孩子是否有咳喘痰的情况？","checkbox", [
          Option("A","无咳嗽喘痰"),
          Option("B","咳嗽"),
          Option("C","气喘"),
          Option("D","有黄痰"),
          Option("E","有白痰"),
          Option("F","有痰吐不出"),
          Option("G","白天不咳嗽，夜间咳嗽明显")
        ]),
        Question("孩子最近是否觉得何处疼痛？","checkbox", [
          Option("A","没有"),
          Option("B","咽喉痛"),
          Option("C","牙痛"),
          Option("D","头痛"),
          Option("E","胸痛"),
          Option("F","胃痛"),
          Option("G","腹痛"),
          Option("H","四肢关节痛"),
        ]),
        Question("孩子的大便频次如何？","radio", [
          Option("A","一天活隔几天一次"),
          Option("B","一天几次"),
          Option("C","几天一次"),
          Option("D","长期便秘")
        ]),
        Question("孩子的大便性状如何？","checkbox", [
          Option("A","性状正常"),
          Option("B","不成形"),
          Option("C","稀水样便"),
          Option("D","粘稠"),
          Option("E","干结"),
          Option("F","有未消化的食物")
        ]),
        Question("孩子小便频率如何？","radio", [
          Option("A","频次正常（5-8次/日）"),
          Option("B","次数较多"),
          Option("C","次数较少"),
          Option("D","夜尿多")
        ]),
        Question("孩子小便颜色如何？","radio", [
          Option("A","清"),
          Option("B","淡黄"),
          Option("C","黄"),
          Option("D","尿血")
        ]),
        Question("孩子最近饮水情况如何？","radio", [
          Option("A","正常"),
          Option("B","较多"),
          Option("C","较少")
        ]),
        Question("孩子最近进食情况如何？","radio", [
          Option("A","正常"),
          Option("B","较多"),
          Option("C","较少")
        ]),
        Question("孩子嘴里是否有异常？","checkbox", [
          Option("A","嘴里无异常"),
          Option("B","口臭"),
          Option("C","口苦"),
          Option("D","口甜"),
          Option("D","口黏腻")
        ]),
        Question("孩子睡眠状况如何？","checkbox", [
          Option("A","睡眠正常"),
          Option("B","入睡难"),
          Option("C","易醒"),
          Option("D","睡觉流涎"),
          Option("D","睡觉不踏实，易翻滚踢被")
        ])
      ]));
      results.add(Ask("女性通用问诊单",1,[]));
      results.add(Ask("男性通用问诊单",1,[]));
      return results;
    });
  }
}