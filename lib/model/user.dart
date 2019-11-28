

class User {
  int id;
  String icon;
  String name;
  String type;
  String level;

  User(this.id,this.icon,this.name,this.type,this.level);

  User.fromJsonMap(Map<String, dynamic> map):
      name = map["name"],
      icon = map["icon"],
      type = map["type"],
      level = map["level"],
      id = map["id"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['icon'] = icon;
    data['type'] = type;
    data['level'] = level;
    data['id'] = id;
    return data;
  }
}