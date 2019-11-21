import 'package:flutter/material.dart';
import 'package:infixedu/utils/CardItem.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/screens/Profile.dart';
import 'package:infixedu/utils/Utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTapped;
  int currentSelectedIndex;
  String _id;
  String _rule;
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    isTapped = false;

    Utils.getStringValue('email').then((value){
      _email = value;
    });

    Utils.getStringValue('password').then((value){
      _password = value;
    });

    Utils.getStringValue('id').then((value){
      _id = value;
      Utils.showToast('$_id');
    });

    Utils.getStringValue('password').then((value){
      _rule = value;
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
        appBar: AppBar(
          primary: false,
          centerTitle: false,
          title:Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Image.asset(
                          'images/inflex_edu_logo.png',
                          width: 80.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 23.0,
                          backgroundImage:
                          NetworkImage('https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
          flexibleSpace: Image(
            image: AssetImage('images/tool_bar_bg.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: GridView.builder(
          itemCount: AppFunction.students.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            return CustomWidget(
              index: index,
              isSelected: currentSelectedIndex == index,
              onSelect: () {
                setState(() {
                  currentSelectedIndex = index;
                  Route route = MaterialPageRoute(builder: (context) => Profile());
                  Navigator.push(context, route);
                });
              },
              headline: AppFunction.students[index],
              icon: AppFunction.studentIcons[index],
            );
          },
        ),
      ),
    );
  }
}

void navigateToPreviousPage(BuildContext context) {
  Navigator.pop(context);
}
