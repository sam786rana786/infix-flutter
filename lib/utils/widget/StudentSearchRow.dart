import 'package:flutter/material.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Student.dart';

class StudentRow extends StatefulWidget {

  Student student;


  StudentRow(this.student);

  @override
  _StudentRowState createState() => _StudentRowState(student);
}

class _StudentRowState extends State<StudentRow> {

  Student student;


  _StudentRowState(this.student);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
