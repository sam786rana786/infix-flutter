class ClassExamName{
  String examName;
  int examId;

  ClassExamName({this.examName, this.examId});

  factory ClassExamName.fromJson(Map<String,dynamic> json){
    return ClassExamName(
      examName: json['exam_name'],
      examId: json['exam_id']
    );
  }
}

class ClassExamList{

  List<ClassExamName> exams;

  ClassExamList(this.exams);

  factory ClassExamList.fromJson(List<dynamic> json){

    List<ClassExamName> exams = List<ClassExamName>();

    exams = json.map((i) => ClassExamName.fromJson(i)).toList();

    return ClassExamList(exams);

  }
}