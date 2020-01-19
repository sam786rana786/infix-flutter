import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:infixedu/utils/CardItem.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

import 'Login.dart';
import 'Profile.dart';

class Home extends StatefulWidget {
  var _titles;
  var _images;

  Home(this._titles, this._images);

  @override
  _HomeState createState() => _HomeState(_titles, _images);
}

class _HomeState extends State<Home> {
  bool isTapped;
  int currentSelectedIndex;
  String _id;
  String _email;
  String _password;
  String _rule;
  var _titles;
  var _images;

  _HomeState(this._titles, this._images);

  @override
  void initState() {
    super.initState();
    isTapped = false;
    Utils.getStringValue('email').then((value) {
      _email = value;
    });
    Utils.getStringValue('password').then((value) {
      _password = value;
    });
    Utils.getStringValue('id').then((value) {
      _id = value;
    });
    Utils.getStringValue('rule').then((value){
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
          title:Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Image.asset(
                    'images/inflex_edu_logo.png',
                    width: 80.0,
                  ),
                ),
                FutureBuilder(
                  future: Utils.getStringValue('email'),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return getProfileImage(context, _email, _password, _rule);
                  },
                ),
              ],
            ),
          flexibleSpace: Image(
            image: AssetImage('images/tool_bar_bg.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
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
                  if(_rule == '2'){
                    AppFunction.getDashboardPage(context, _titles[index]);
                  }else if(_rule == '4'){
                    AppFunction.getTeacherDashboardPage(context, _titles[index]);
                  }else if(_rule == '3'){
                    AppFunction.getParentDashboardPage(context, _titles[index]);
                  }
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

showStudentProfileDialog(BuildContext context) {
  showDialog<void>(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                    //color: const Color(0xFF66BB6A),
                    boxShadow: [BoxShadow(
                      color: Colors.deepPurple,
                      blurRadius: 20.0,
                    ),]
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0,right: 15.0),
                    child: ListView(
                      children: <Widget>[
                        GestureDetector(
                          child: Text(
                            "Profile",
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          onTap: () {
                            Navigator.push(context, ScaleRoute(page: Profile()));
                          },
                        ),
                        Text(
                          "Change Password",
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline,
                        ),
                        GestureDetector(
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          onTap: (){
                            showAlertDialog(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
showOhtersProfileDialog(BuildContext context) {
  showDialog<void>(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                    //color: const Color(0xFF66BB6A),
                    boxShadow: [BoxShadow(
                      color: Colors.deepPurple.shade300,
                      blurRadius: 20.0,
                    ),]
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0,right: 15.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          "Change Password",
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(height: 10.0,),
                        GestureDetector(
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          onTap: (){
                            showAlertDialog(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget yesButton = FlatButton(
    child: Text("yes"),
    onPressed: () {
      Utils.clearAllValue();
      Route route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushAndRemoveUntil(context, route,ModalRoute.withName('/'));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Logout",
      style: Theme.of(context).textTheme.headline,
    ),
    content: Text("Would you like to logout?"),
    actions: [
      cancelButton,
      yesButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget getProfileImage(
    BuildContext context, String email, String password, String rule) {
  return FutureBuilder(
    future: getImageUrl(email, password, rule),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.hasData) {
        Utils.saveStringValue('image', snapshot.data);
        return GestureDetector(
          onTap: () {
            rule == '2' ? showStudentProfileDialog(context) : showOhtersProfileDialog(context);
          },
          child: Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: CircleAvatar(
                  radius: 22.0,
                  backgroundImage: NetworkImage(snapshot.data),
                  backgroundColor: Colors.transparent,
                ),
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () {
            rule == '2' ? showStudentProfileDialog(context) : showOhtersProfileDialog(context);
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      }
    },
  );
}

Future<String> getImageUrl(String email, String password, String rule) async {
  var image = 'https://i.imgur.com/BoN9kdC.png';

  var response = await http.get(InfixApi.login(email, password));

  if (response.statusCode == 200) {
    Map<String, dynamic> user = jsonDecode(response.body) as Map;
    if (rule == '2')
      image = InfixApi.root + user['data']['userDetails']['student_photo'];
    else if (rule == '3')
      image = InfixApi.root + user['data']['userDetails']['fathers_photo'];
    else
      image = InfixApi.root + user['data']['userDetails']['staff_photo'];
  }
  return '$image';
}

void navigateToPreviousPage(BuildContext context) {
  Navigator.pop(context);
}
