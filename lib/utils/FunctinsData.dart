import 'package:flutter/material.dart';
import 'package:infixedu/screens/Home.dart';
import 'package:infixedu/utils/Utils.dart';

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
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png',
    'images/fees_icon.png'
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
}
