class Dormitory {
  String dormitoryName;
  String roomNumber;
  int numberOfBed;
  int costPerBed;
  int activeStatus;

  Dormitory(
      {this.dormitoryName,
      this.roomNumber,
      this.numberOfBed,
      this.costPerBed,
      this.activeStatus});

  factory Dormitory.fromJson(Map<String, dynamic> json) {
    return Dormitory(
      dormitoryName: json['dormitory_name'],
      roomNumber: json['room_number'],
      numberOfBed: json['number_of_bed'],
      costPerBed: json['cost_per_bed'],
      activeStatus: json['active_status']
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
