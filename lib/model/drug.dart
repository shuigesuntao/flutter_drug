

class Drug{
  String name;
  String unit;
  int count;
  int unitCount;
  String methodText;
  double price;
  int short;//1 不缺 0 缺药

  Drug(this.name,this.count,{this.unit='克',this.unitCount,this.methodText,this.short = 1,this.price = 1.2});
}