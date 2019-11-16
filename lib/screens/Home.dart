import 'package:flutter/material.dart';
import 'package:infixedu/utils/CardItem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isTapped;

  @override
  void initState() {
    super.initState();
    isTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('infix'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigateToPreviousPage(context);
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: CardItem(
                text: 'profile',
              )),
              Expanded(
                  child: CardItem(
                text: 'Attendance',
              )),
              Expanded(
                  child: CardItem(
                text: 'Subjects',
              )),
              Expanded(
                  child: CardItem(
                text: 'Exam',
              )),
            ],
          ),
        ));
  }
}

void navigateToPreviousPage(BuildContext context) {
  Navigator.pop(context);
}
