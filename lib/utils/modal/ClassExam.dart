class ClassExamResult{
  String examName;
  String subject;
  String marks;
  String obtains;
  String grade;


  ClassExamResult({this.examName, this.subject, this.marks, this.obtains,
      this.grade});

  factory ClassExamResult.fromJson(Map<String,dynamic> json){
    return ClassExamResult(
      examName: json['exam_name'],
      subject: json['subject_name'],
      marks: json['exam_mark'],
      obtains: json['obtained_marks'],
      grade: json['grade']
    );
  }
}

class ClassExamResultList{

  List<ClassExamResult> results;

  ClassExamResultList(this.results);

  factory ClassExamResultList.fromJson(List<dynamic> json){

    List<ClassExamResult> resultList = List<ClassExamResult>();

    resultList = json.map((i) => ClassExamResult.fromJson(i)).toList();

    return ClassExamResultList(resultList);

  }

}