
class Category{
  int id;
  String name;
  String imageUrl;
  List<DrugStore> child;

  Category(this.id,this.name,this.imageUrl,this.child);
}

class DrugStore{
  int id; //1 特供 2 上乘 3 中乘
  String name;
  String label;
  String desc;
  String detailUrl;

  DrugStore(this.id,this.name,this.label,this.desc,this.detailUrl);
}