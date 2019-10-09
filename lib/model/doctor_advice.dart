
class DoctorAdvice {
  int id;
  String content;
  int type; //1 饮片
  int top; //1 置顶 0 未置顶
  String createTime;

  DoctorAdvice(this.id,this.content,this.type,this.top,this.createTime);
}