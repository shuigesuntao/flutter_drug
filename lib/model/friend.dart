
import 'package:azlistview/azlistview.dart';

class Friend extends ISuspensionBean{
  String name;
  String displayName;
  String headerUrl;
  String gender;
  int age;
  int askCount;
  int buyDrugCount;
  String tagIndex;
  String namePinyin;
  String phone;

  Friend(
    this.name,
    this.displayName,
    this.headerUrl,
    this.gender,
    this.age,
    this.phone,
    this.askCount,
    this.buyDrugCount, {
    this.tagIndex,
    this.namePinyin}
  );

  @override
  String getSuspensionTag() => tagIndex;

  Friend.fromJson(Map<String, dynamic> json)
    : name = json['name'] == null ? "" : json['name'],
      displayName = json['displayName'] == null ? "" : json['displayName'],
      headerUrl = json['headerUrl'] == null ? "" : json['headerUrl'],
      gender = json['gender'] == null ? "" : json['gender'],
      age = json['age'] == null ? "" : json['age'],
      askCount = json['askCount'] == null ? "" : json['askCount'],
      buyDrugCount = json['buyDrugCount'] == null ? "" : json['buyDrugCount'],
      phone = json['phone'] == null ? "" : json['phone'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'displayName': displayName,
    'headerUrl': headerUrl,
    'gender': gender,
    'tagIndex': tagIndex,
    'age': age,
    'askCount': askCount,
    'buyDrugCount': buyDrugCount,
    'namePinyin': namePinyin,
    'phone': phone,
    'isShowSuspension': isShowSuspension
  };


}