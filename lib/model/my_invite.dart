

class MyInvite{
  String name;
  String imageUrl;
  int type; //0 用户 1 医生
  int auth; //0 未认证 1 已认证
  String gender;
  String phone;
  String time;

  MyInvite(this.name,this.imageUrl,this.type,this.auth,this.gender,this.phone,this.time);
}