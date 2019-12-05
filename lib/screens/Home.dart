import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:infixedu/utils/CardItem.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';

import 'Login.dart';

class Home extends StatefulWidget {
  var _titles;
  var _images;

  Home(this._titles,this._images);

  @override
  _HomeState createState() => _HomeState(_titles,_images);
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

  _HomeState(this._titles,this._images);

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
    Utils.getStringValue('rule').then((value) {
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
          title: Container(
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
                FutureBuilder(
                  future:  Utils.getStringValue('email'),
                  builder: (BuildContext context,AsyncSnapshot<String> snapshot){
                    return getProfileImage(context,_email,_password,_rule);
                  },
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
                  AppFunction.getDashboardPage(context, _titles[index]);
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
      Route route = MaterialPageRoute(builder: (context) => LoginScreen());
      Utils.clearAllValue();
      prefix0.Navigator.pop(context);
      Navigator.pushReplacement(context, route);
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

Widget getProfileImage(BuildContext context,String email,String password,String rule) {

  return FutureBuilder(
    future: getImageUrl(email, password, rule),
    builder: (BuildContext context,AsyncSnapshot<String> snapshot){

      if(snapshot.hasData){
        Utils.saveStringValue('image', snapshot.data);
        return GestureDetector(
          onTap: () {
            showAlertDialog(context);
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(snapshot.data),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      }else{
        return GestureDetector(
          onTap: () {
            showAlertDialog(context);
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


Future<String> getImageUrl(String email,String password,String rule) async{

  var image = 'https://i.imgur.com/BoN9kdC.png';

  var response = await http.get(InfixApi.login(email, password));

  if(response.statusCode == 200){
    Map<String, dynamic> user = jsonDecode(response.body) as Map;

    if(rule == '2')image = user['data']['userDetails']['student_photo'];
    else image = user['data']['userDetails']['staff_photo'];
  }
return InfixApi.root + '$image';
}


void navigateToPreviousPage(BuildContext context) {
  Navigator.pop(context);
}
