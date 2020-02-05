import 'package:flutter/material.dart';
class BottomLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 0.5,
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Colors.purple, Colors.deepPurple]),
        ),
      ),
    );
  }
}
