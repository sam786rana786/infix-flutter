import 'package:flutter/material.dart';
import 'package:infixedu/screens/Dormitory.dart';
import 'package:infixedu/screens/StudentTeacher.dart';
import 'package:infixedu/screens/SubjectScreen.dart';
import 'package:infixedu/screens/TransportScreen.dart';
import 'package:infixedu/screens/Home.dart';
import 'package:infixedu/screens/Routine.dart';
import 'package:infixedu/screens/StudentHomework.dart';
import 'package:infixedu/screens/TransportScreen.dart' as prefix0;
import 'package:infixedu/utils/widget/ScaleRoute.dart';
import 'package:infixedu/screens/Profile.dart';
import 'package:infixedu/screens/Fees.dart';

import 'modal/Transport.dart';

class AppFunction {
  static var students = [
    'Profile',
    'Fees',
    'Routine',
    'Homework',
    'Timeline',
    'Attendance',
    'Examination',
    'Online Exam',
    'Notice',
    'Subjects',
    'Teacher',
    'Library',
    'Transport',
    'Dormitory'
  ];
  static var studentIcons = [
    'images/profile.png',
    'images/fees_icon.png',
    'images/routine.png',
    'images/homework.png',
    'images/timeline.png',
    'images/attendance.png',
    'images/examination.png',
    'images/onlineexam.png',
    'images/notice.png',
    'images/subjects.png',
    'images/teacher.png',
    'images/library.png',
    'images/transport.png',
    'images/dormitory.png'
  ];

  static var admins = [
    'Students',
    'Leave',
    'Staff',
    'Dormitory',
    'Attendance',
    'Fees',
    'Library',
    'Transport'
  ];
  static var adminIcons = [
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
  ];

  static void getFunctions(BuildContext context, String rule) {
    Route route;

    switch (rule) {
      case '1':
        route =
            MaterialPageRoute(builder: (context) => Home(admins, adminIcons));
        Navigator.pushReplacement(context, route);
        break;
      case '2':
        route = MaterialPageRoute(
            builder: (context) => Home(students, studentIcons));
        Navigator.pushReplacement(context, route);
        break;
      case '3':
        route = MaterialPageRoute(
            builder: (context) => Home(students, studentIcons));
        Navigator.pushReplacement(context, route);
        break;
      case '4':
        route = MaterialPageRoute(
            builder: (context) => Home(students, studentIcons));
        Navigator.pushReplacement(context, route);
        break;
    }
  }

  static void getDashboardPage(BuildContext context, String title) {
    switch (title) {
      case 'Profile':
        Navigator.push(context, ScaleRoute(page: Profile()));
        break;
      case 'Fees':
        Navigator.push(context, ScaleRoute(page: Fees_screen()));
        break;
      case 'Routine':
        Navigator.push(context, ScaleRoute(page: Routine()));
        break;
      case 'Homework':
        Navigator.push(context, ScaleRoute(page: StudentHomework()));
        break;
      case 'Dormitory':
        Navigator.push(context, ScaleRoute(page: DormitoryScreen()));
        break;
      case 'Transport':
        Navigator.push(context, ScaleRoute(page: TransportScreen()));
        break;
      case 'Subjects':
        Navigator.push(context, ScaleRoute(page: SubjectScreen()));
        break;
      case 'Teacher':
        Navigator.push(context, ScaleRoute(page: StudentTeacher()));
        break;
    }
  }

  static var weeks = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'thursday',
    'Friday',
  ];

  static String getAmPm(String time) {
    var parts = time.split(":");
    String part1 = parts[0];
    String part2 = parts[1];

    int hr = int.parse(part1);
    int min = int.parse(part2);

    if (hr <= 12) {
      return "$hr:$min AM ";
    } else {
      return "$hr:$min PM ";
    }
  }

  static String getExtention(String url) {
    var parts = url.split("/");

    return parts[parts.length - 1];
  }
}
