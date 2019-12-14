class Dormitory {
  String dormitory_name;
  String room_number;
  int number_of_bed;
  int cost_per_bed;
  int active_status;

  Dormitory(
      {this.dormitory_name,
      this.room_number,
      this.number_of_bed,
      this.cost_per_bed,
      this.active_status});

  factory Dormitory.fromJson(Map<String, dynamic> json) {
    return Dormitory(
      dormitory_name: json['dormitory_name'],
      room_number: json['room_number'],
      number_of_bed: json['number_of_bed'],
      cost_per_bed: json['cost_per_bed'],
      active_status: json['active_status']
    );
  }
}
class DormitoryList{

  List<Dormitory> dormitories;

  DormitoryList(this.dormitories);

  factory DormitoryList.fromJson(List<dynamic> jsonArr){

    List<Dormitory> dormitorylist = List<Dormitory>();

    dormitorylist = jsonArr.map((i)=> Dormitory.fromJson(i)).toList();

    return DormitoryList(dormitorylist);

  }


}
