import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import '../main.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<bool> isSelected = [false, false];

  @override
  void initState() {
    super.initState();
    Utils.getIntValue('locale').then((value) {
      setState(() {
        isSelected[value] = true;
        Utils.showToast('$value');
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
        appBar: AppBarWidget.header(context, 'Settings'),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: toggleButton(context),
                ),
                elevation: 5.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleButton(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'System Locale',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          ToggleButtons(
            borderColor: Colors.deepPurple,
            fillColor: Colors.deepPurple.shade200,
            borderWidth: 2,
            selectedBorderColor: Colors.deepPurple,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'RTL',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'popins',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'LTL',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'popins',
                  ),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                Utils.saveIntValue('locale', index);
                rebuildAllChildren(context);
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                  } else {
                    isSelected[i] = false;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
//    Navigator.of(context)
//        .push(MaterialPageRoute(builder: (BuildContext context) {
//      return MyApp();
    Route route = MaterialPageRoute(builder: (context) => MyApp());
    Navigator.pushAndRemoveUntil(context, route, ModalRoute.withName('/'));
  }
}
