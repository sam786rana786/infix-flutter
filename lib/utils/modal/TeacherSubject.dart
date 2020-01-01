class teacherSubject {
  String subjectName;
  String subjectCode;
  String subjectType;

  teacherSubject({this.subjectName, this.subjectCode, this.subjectType});

  factory teacherSubject.fromJson(Map<String, dynamic> json) {
    return teacherSubject(
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
      subjectType: json['subject_type'],
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
