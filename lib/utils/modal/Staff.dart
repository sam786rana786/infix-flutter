import 'package:flutter/foundation.dart';

class Staff {
  int id;
  String name;
  String qualification;
  String currentAddress;
  String title;
  String maritalStatus;
  String dateOfJoining;
  String phone;

  Staff(
      {this.id,
      this.name,
      this.qualification,
      this.currentAddress,
      this.title,
      this.maritalStatus,
      this.dateOfJoining,
      this.phone});

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      name: json['full_name'],
      qualification: json['qualification'],
      currentAddress: json['current_address'],
      title: json['title'],
      maritalStatus: json['marital_status'],
      dateOfJoining: json['date_of_joining'],
      phone: json['mobile'],
    );
  }
}

class StaffList {

  List<Staff> staffs;

  StaffList(this.staffs);

  factory StaffList.fromJson(List<dynamic> json) {
    List<Staff> staffList = List<Staff>();

    staffList = json.map((i) => Staff.fromJson(i)).toList();
    return StaffList(staffList);
  }
}
