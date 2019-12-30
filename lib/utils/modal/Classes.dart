class Classes {
  String name;
  int id;

  Classes({this.name, this.id});

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(name: json['class_name'], id: json['class_id']);
  }
}

class ClassList {

  List<Classes> classes = List<Classes>();

  ClassList(this.classes);

  factory ClassList.fromJson(List<dynamic> json) {
    List<Classes> classList;

    classList = json.map((i) => Classes.fromJson(i)).toList();

    return ClassList(classList);
  }
}
