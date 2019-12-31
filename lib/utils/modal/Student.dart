class Student{

  int id;
  String photo;
  String name;
  int roll;
  String className;
  String sectionName;

  Student({this.id, this.photo, this.name, this.roll, this.className,
      this.sectionName});


  factory Student.fromJson(Map<String,dynamic> json){
    return Student(
      id: json['user_id'],
      photo: json['student_photo'],
      name: json['full_name'],
      roll: json['roll_no'],
      className: json['class_name'],
      sectionName: json['section_name'],
    );
  }
}
class StudentList{

  List<Student> students;

  StudentList(this.students);

  factory StudentList.fromJson(List<dynamic> json){

    List<Student> studentlist = List<Student>();

    studentlist = json.map((i) => Student.fromJson(i)).toList();

    return StudentList(studentlist);

  }

}