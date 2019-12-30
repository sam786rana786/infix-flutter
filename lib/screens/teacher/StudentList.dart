import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/StudentSearchRow.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {


    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Student List'),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index){
            return StudentRow();
          },
        ),
      ),
    );
  }
}
