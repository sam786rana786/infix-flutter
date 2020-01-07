import 'package:flutter/material.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/GlobalClass.dart';
import 'package:infixedu/utils/modal/Student.dart';
import 'package:http/http.dart' as http;

class StudentAttendanceRow extends StatefulWidget {
  Student student;
  String mClass,mSection,date;

  StudentAttendanceRow(this.student,this.mClass,this.mSection,this.date);

  @override
  _StudentAttendanceRowState createState() =>
      _StudentAttendanceRowState(student,mClass,mSection,date);
}

class _StudentAttendanceRowState extends State<StudentAttendanceRow> {
  Student student;
  bool isSelected = true;
  String mClass,mSection,date;
  String atten = 'P';
  var function = GlobalDatae();

  _StudentAttendanceRowState(this.student,this.mClass,this.mSection,this.date);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          atten = isSelected ? 'P' : 'A';
          isSelected ? function.sub():function.add();
          setAttendance();
        });
      },
      splashColor: Colors.purple.shade200,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: isSelected
                ? CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.greenAccent.shade700,
                    child: Icon(Icons.done,color: Colors.white,),
                  )
                : CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage(InfixApi.root + student.photo),
                    backgroundColor: Colors.transparent,
                  ),
            title: Text(
              student.name,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
                'Class : ${student.className} | Section : ${student.sectionName}',
                style: Theme.of(context).textTheme.display1),
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
  void setAttendance() async {
    final response = await http.get(InfixApi.attendance_data_send('${student.uid}', atten, date, mClass, mSection));
    if (response.statusCode == 200) {
      debugPrint('Attendance successful');
    } else {
      throw Exception('Failed to load');
    }

  }
}
