import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Schedule.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/Routine_row.dart';
import 'package:infixedu/utils/widget/TeacherMyRoutineItem.dart';

class TeacherMyRoutineScreen extends StatelessWidget {

  List<String> weeks = AppFunction.weeks;

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'My Routine'),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: weeks.length,
          itemBuilder: (context,index){
            return TeacherRoutineRow(title:weeks[index]);
          },
        ),
      ),
    );
  }

}
