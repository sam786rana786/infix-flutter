class AdminSubject {
  String title;
  int id;

  AdminSubject({this.title, this.id});

  factory AdminSubject.fromJson(Map<String, dynamic> json) {
    return AdminSubject(
      title: json['subject_name'],
      id: json['id'],
    );
  }
}

class AdminSubjectList {
  List<AdminSubject> subjects;

  AdminSubjectList(this.subjects);

  factory AdminSubjectList.fromJson(List<dynamic> json) {
    List<AdminSubject> subjects = List<AdminSubject>();

    subjects = json.map((i) => AdminSubject.fromJson(i)).toList();

    return AdminSubjectList(subjects);
  }
}
