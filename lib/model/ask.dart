class Ask{
  String name;
  int status;
  List<Question> questions;

  Ask(this.name,this.status,this.questions);
}

class Question{
  String title;
  String type;
  List<Option> options;
  Question(this.title,this.type,this.options);
}

class Option{
  String label;
  String option;
  Option(this.label,this.option);
}
