import 'package:flutter/material.dart';

class StudentRow extends StatefulWidget {
  @override
  _StudentRowState createState() => _StudentRowState();
}

class _StudentRowState extends State<StudentRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
            backgroundColor: Colors.transparent,
          ),
          title: Text("Mamun Hossain",style: Theme.of(context).textTheme.title,),
          subtitle: Text('Class : One | Section : A',style: Theme.of(context).textTheme.display1),
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
