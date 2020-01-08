class teacherSubject {
  String subjectName;
  String subjectCode;
  String subjectType;
  int subjectId;

  teacherSubject({this.subjectName, this.subjectCode, this.subjectType,this.subjectId});

  factory teacherSubject.fromJson(Map<String, dynamic> json) {
    return teacherSubject(
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
      subjectType: json['subject_type'],
      subjectId: json['subject_id'],
    );
  }
}

class TeacherSubjectList {
  List<teacherSubject> subjects;

  TeacherSubjectList(this.subjects);

  factory TeacherSubjectList.fromJson(List<dynamic> json) {
    List<teacherSubject> subjects = List<teacherSubject>();

    subjects = json.map((i) => teacherSubject.fromJson(i)).toList();

    return TeacherSubjectList(subjects);
  }
}
