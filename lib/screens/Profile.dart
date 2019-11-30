import 'package:flutter/material.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/server/ProfileService.dart';
import 'package:infixedu/utils/modal/InfixMap.dart';
import 'package:infixedu/utils/widget/ProfileListRow.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isPersonal = false;
  bool isParents = false;

  bool isTransport = false;
  bool isOthers = false;

  ProfileService profileService =
      ProfileService('regan1@infixedu.com', '123456');

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Profile'),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://i.imgur.com/BoN9kdC.png")))),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Ralph o' 'elly',
                            style: Theme.of(context).textTheme.headline),
                        Text(
                          'Class : One | Section : A',
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          'Roll : 82547 | Adm : 16235',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 23.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPersonal = true;
                            isParents = false;
                            isTransport = false;
                            isOthers = false;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Personal',
                              style: Theme.of(context).textTheme.title,
                            ),
                            Container(
                              height: 2.0,
                              decoration: BoxDecoration(
                                color: isPersonal
                                    ? Colors.deepPurpleAccent
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isParents = true;
                            isPersonal = false;
                            isTransport = false;
                            isOthers = false;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Parents',
                              style: Theme.of(context).textTheme.title,
                            ),
                            Container(
                              height: 2.0,
                              decoration: BoxDecoration(
                                color: isParents
                                    ? Colors.deepPurpleAccent
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTransport = true;
                            isParents = false;
                            isPersonal = false;
                            isOthers = false;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Transport',
                              style: Theme.of(context).textTheme.title,
                            ),
                            Container(
                              height: 2.0,
                              decoration: BoxDecoration(
                                color: isTransport
                                    ? Colors.deepPurpleAccent
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTransport = false;
                            isParents = false;
                            isPersonal = false;
                            isOthers = true;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Others',
                              style: Theme.of(context).textTheme.title,
                            ),
                            Container(
                              height: 2.0,
                              decoration: BoxDecoration(
                                color: isOthers
                                    ? Colors.deepPurpleAccent
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 15.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff3e5f5).withOpacity(0.5), Colors.white]),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: profileService.fetchPersonalServices(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<InfixMap>> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Profile_row_list(snapshot.data[index].key,
                              snapshot.data[index].value);
                        },
                      );
                    } else {
                      return Text(
                        'Loading...',
                        style: Theme.of(context).textTheme.headline,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }
}
