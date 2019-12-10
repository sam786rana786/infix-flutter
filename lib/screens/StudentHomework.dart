import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/Homework_row.dart';

class StudentHomework extends StatefulWidget {
  @override
  _StudentHomeworkState createState() => _StudentHomeworkState();
}

class _StudentHomeworkState extends State<StudentHomework> {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
          appBar: AppBarWidget.header(context, 'Homework'),
          backgroundColor: Colors.white,
          body: Student_homework_row(),
        ),
    );
  }
}
