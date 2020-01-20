import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infixedu/utils/CardItem.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';


class OnlineExaminationHome extends StatefulWidget {
  var _titles;
  var _images;
  var id;

  OnlineExaminationHome(this._titles,this._images,{this.id});

  @override
  _HomeState createState() => _HomeState(_titles,_images);
}

class _HomeState extends State<OnlineExaminationHome> {
  bool isTapped;
  int currentSelectedIndex;
  String _id;
  var _titles;
  var _images;

  _HomeState(this._titles,this._images);

  @override
  void initState() {
    super.initState();
    isTapped = false;


    Utils.getStringValue('id').then((value) {
      _id = value;
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
        appBar: AppBarWidget.header(context,'Online Examination'),
        backgroundColor: Colors.white,
        body: GridView.builder(
          itemCount: _titles.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            return CustomWidget(
              index: index,
              isSelected: currentSelectedIndex == index,
              onSelect: () {
                setState(() {
                  currentSelectedIndex = index;
                  AppFunction.getOnlineExaminationDashboardPage(context, _titles[index],id: widget.id);
                });
              },
              headline: _titles[index],
              icon: _images[index],
            );
          },
        ),
      ),
    );
  }
}
