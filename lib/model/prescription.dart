

class Prescription{
  int status; //0 全部 1 未支付 2 已付款 3 已发货 4 已完成
  String statusText; //0 全部 1 未支付 2 已付款 3 已发货 4 已完成
  String name;
  String gender;
  int age;
  String symptom; // 症状
  double price; // 药费
  String time;

  Prescription(this.status,this.statusText,this.name,this.gender,this.age,this.symptom,this.price,this.time);
}