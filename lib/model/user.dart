

class User {
  int id;
  String icon;
  String name;
  String level;

  User(this.id,this.icon,this.name,this.level);

  User.fromJsonMap(Map<String, dynamic> map):
      name = map["name"],
      icon = map["icon"],
      level = map["level"],
      id = map["id"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['icon'] = icon;
    data['level'] = level;
    data['id'] = id;
    return data;
  }
}