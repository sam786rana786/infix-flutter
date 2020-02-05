import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/server/About.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/Line.dart';

class AdminSettings extends StatefulWidget {
  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  Response response;
  Dio dio = Dio();
  int id;
  int perm;
  GlobalKey _scaffold = GlobalKey();


  @override
  void initState() {
    super.initState();
    Utils.getStringValue('id').then((value) {
      id = int.parse(value);
      About.PhonePermission().then((val) {
        setState(() {
          perm = val;
        });
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
        key: _scaffold,
        appBar: AppBarWidget.header(context, 'Settings'),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Card(
                elevation: 10,
                color: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(
                    Icons.settings_cell,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                'Phone Number',
                style: Theme.of(context).textTheme.title,
              ),
              trailing: GestureDetector(
                onTap: () {
                  showAlertDialog(_scaffold.currentContext);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: perm == 1 ? Colors.deepPurple:Colors.redAccent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        perm == 1 ?'Enable':'Disable',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.white),
                      ),
                    )),
              ),
              dense: true,
            ),
            BottomLine(),
          ],
        ),
      ),
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
        //Navigator.of(context).pop();
        setPermission(perm == 1 ? 0 : 1);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Number permission",
        style: Theme.of(context).textTheme.headline,
      ),
      content: Text("Would you like to change permission?"),
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

  Future<void> setPermission(int mPer) async {
    response = await dio.get(InfixApi.getTeacherPhonePermission(mPer));
    if (response.statusCode == 200) {
      setState(() {
        Navigator.of(context).pop();
        perm = mPer;
      });
    }
  }
}
