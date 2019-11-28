import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:infixedu/utils/CardItem.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/screens/Profile.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import './Login.dart';

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
  String _image;
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

    Utils.getStringValue('image').then((value) {
      setState(() {
        _image = InfixApi.root + value;
        Utils.showToast(_image);
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
                getProfileImage(_image, context),
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
                  Route route =
                      MaterialPageRoute(builder: (context) => Profile());
                  Navigator.push(context, route);
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

Widget getProfileImage(String image, BuildContext context) {

  return GestureDetector(
    onTap: () {
      showAlertDialog(context);
    },
    child: Align(
      alignment: Alignment.bottomRight,
      child: CircleAvatar(
        radius: 25.0,
        backgroundImage: NetworkImage('$image'),
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}

void navigateToPreviousPage(BuildContext context) {
  Navigator.pop(context);
}
