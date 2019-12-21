import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/ClassExamList.dart';
import 'package:infixedu/utils/modal/ClassExamSchedule.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:infixedu/utils/widget/ExamRow.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var _selected;
  var _data = ['mamunu','hossain','munna','mia'];

  Future<ClassExamList> exams;
  Future<classExamScheduleList> examlist;
  int id;
  int code;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Utils.getStringValue('id').then((value) {
      setState(() {
        id = int.parse(value);
        exams = getAllClassExam(int.parse(value));
        exams.then((val) {
          _selected = _data[0];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Schedule'),
        backgroundColor: Colors.white,
        body: FutureBuilder<ClassExamList>(
          future: exams,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  getDropdown(snapshot.data.exams),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(child: getExamList())
                ],
              );
            } else {
              return Center(child: Text("loading..."));
            }
          },
        ),
      ),
    );
  }

  Widget getDropdown(List<ClassExamName> exams) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: _data.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0),
        onChanged: (value) {
          setState(() {
            _selected = value;
            debugPrint('User select $value');
            //examlist = getAllClassExamSchedule(id, )
          });
        },
        value: _selected,
      ),
    );
  }

  Widget getExamList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Student_Exam_row();
      },
    );
  }

  Future<ClassExamList> getAllClassExam(int id) async {
    final response = await http.get(InfixApi.getStudentClassExamName(id));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return ClassExamList.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<classExamScheduleList> getAllClassExamSchedule(
      int id, int code) async {
    final response =
        await http.get(InfixApi.getStudentClsExamShedule(id, code));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return classExamScheduleList.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
