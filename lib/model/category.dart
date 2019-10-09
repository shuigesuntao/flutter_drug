
class Category{
  int id;
  String name;
  String imageUrl;
  List<DrugStore> child;

  Category(this.id,this.name,this.imageUrl,this.child);
}

class DrugStore{
  int id;
  String name;
  String label;
  String desc;

  DrugStore(this.id,this.name,this.label,this.desc);
}