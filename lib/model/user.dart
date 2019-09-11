

class User {
  int id;
  String icon;
  String name;

  User.fromJsonMap(Map<String, dynamic> map):
      name = map["name"],
      icon = map["icon"],
      id = map["id"];
}