import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Teacher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/Student_teacher_row_layout.dart';

class StudentTeacher extends StatefulWidget {
  @override
  _StudentTeacherState createState() => _StudentTeacherState();
}

class _StudentTeacherState extends State<StudentTeacher> with SingleTickerProviderStateMixin{

  Future<TeacherList> teachers;

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation = Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Utils.getStringValue('id').then((value) {
      setState(() {
        teachers = getAllTeacher(int.parse(value));
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo,
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Teachers'),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context,child){
                    return Container(
                      transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Teacher Name',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                    fontSize: 13.0, fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                            child: Text('Email',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                    fontSize: 13.0, fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                            child: Text('Phone',
                                style: Theme.of(context).textTheme.display1.copyWith(
                                    fontSize: 13.0, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder<TeacherList>(
                future: teachers,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.teachers.length,
                      itemBuilder: (context, index) {
                        return StudentTeacherRowLayout(snapshot.data.teachers[index]);
                      },
                    );
                  }else{
                    return Center(child: Text("Loading..."));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<TeacherList> getAllTeacher(int id) async {
    final response = await http.get(InfixApi.getStudentTeacherUrl(16));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return TeacherList.fromJson(jsonData['data']['teacher_list']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
