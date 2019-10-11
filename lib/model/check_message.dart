
class CheckMessage{
  String title;
  int status;//1 待确认 2 审核中
  String statusText;
  String time;
  String desc;

  CheckMessage(this.title,this.status,this.statusText,this.desc,this.time);
}