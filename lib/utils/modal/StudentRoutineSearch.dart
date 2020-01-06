class StudentRoutineSearch{

  String period;
  String start_time;
  String end_time;
  String subject;
  String room;

  StudentRoutineSearch({this.period, this.start_time, this.end_time,
      this.subject, this.room});

  factory StudentRoutineSearch.fromJson(Map<String,dynamic> json){
    return StudentRoutineSearch(
      period: json['period'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      subject: json['subject_name'],
      room: json['room_no']
    );
  }
}

class RoutineSearchList{

  List<StudentRoutineSearch> searchs;

  RoutineSearchList(this.searchs);


  factory RoutineSearchList.fromJson(List<dynamic> json){

    List<StudentRoutineSearch> searchList = List<StudentRoutineSearch>();

    searchList = json.map((i) => StudentRoutineSearch.fromJson(i)).toList();

    return RoutineSearchList(searchList);
  }
}