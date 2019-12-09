import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/Routine_row.dart';

class Routine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
          appBar: AppBarWidget.header(context, 'Routine'),
          backgroundColor: Colors.white,
          body: RoutineRow(),
        ),
    );
  }
}
