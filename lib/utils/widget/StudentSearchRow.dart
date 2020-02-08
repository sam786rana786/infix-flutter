import 'package:flutter/material.dart';
import 'package:infixedu/screens/Profile.dart';
import 'package:infixedu/screens/StudentAttendance.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Student.dart';

import 'ScaleRoute.dart';

// ignore: must_be_immutable
class StudentRow extends StatefulWidget {

  Student student;
  String status;


  StudentRow(this.student,{this.status});

  @override
  _StudentRowState createState() => _StudentRowState(student,status: status);
}

class _StudentRowState extends State<StudentRow> {

  Student student;
  String status;


  _StudentRowState(this.student,{this.status});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(status == 'attendance'){
          Navigator.push(context,
              ScaleRoute(page: StudentAttendanceScreen(id: student.id,)));
        }else{
          Navigator.push(context, ScaleRoute(page: Profile(id: student.id.toString(),image: InfixApi.root+student.photo,)));
        }
      },
      splashColor: Colors.purple.shade200,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(InfixApi.root+student.photo),
              backgroundColor: Colors.transparent,
            ),
            title: Text(student.name,style: Theme.of(context).textTheme.title,),
            subtitle: Text('Class : ${student.className} | Section : ${student.sectionName}',style: Theme.of(context).textTheme.display1),
          ),
          Container(
            height: 0.5,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.purple, Colors.deepPurple]),
            ),
          )
        ],
      ),
    );
  }
}
