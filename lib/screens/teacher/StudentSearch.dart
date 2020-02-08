import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Classes.dart';
import 'package:infixedu/utils/modal/Section.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

import 'StudentListScreen.dart';
import 'StudentSearchNameAndRoll.dart';

// ignore: must_be_immutable
class StudentSearch extends StatefulWidget {
  String status;

  StudentSearch({this.status});

  @override
  _StudentSearchState createState() => _StudentSearchState(status: status);
}

class _StudentSearchState extends State<StudentSearch> {
  String _id;
  int classId;
  int sectionId;
  String _selectedClass;
  String _selectedSection;
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  Future<ClassList> classes;
  Future<SectionList> sections;
  String url;
  String status;

  _StudentSearchState({this.status});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Utils.getStringValue('id').then((value) {
      setState(() {
        _id = value;
        classes = getAllClass(int.parse(_id));
        classes.then((value) {
          _selectedClass = value.classes[0].name;
          classId = value.classes[0].id;
          sections = getAllSection(int.parse(_id), classId);
          sections.then((sectionValue) {
            _selectedSection = sectionValue.sections[0].name;
            sectionId = sectionValue.sections[0].id;
          });
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
        appBar: AppBarWidget.header(context, 'Student search'),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<ClassList>(
              future: classes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: <Widget>[
                      getClassDropdown(snapshot.data.classes),
                      FutureBuilder<SectionList>(
                        future: sections,
                        builder: (context, secSnap) {
                          if (secSnap.hasData) {
                            return getSectionDropdown(secSnap.data.sections);
                          } else {
                            return Center(child: Text("loading..."));
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.display1,
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: "Search by name",
                              labelText: "Name",
                              labelStyle: Theme.of(context).textTheme.display1,
                              errorStyle: TextStyle(
                                  color: Colors.pinkAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.display1,
                          controller: rollController,
                          decoration: InputDecoration(
                              hintText: "Search by roll",
                              labelText: "Roll",
                              labelStyle: Theme.of(context).textTheme.display1,
                              errorStyle: TextStyle(
                                  color: Colors.pinkAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.height / 2 - 100),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.purple,
                            ),
                            child: Text(
                              "Search",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                        onTap: () {
                          String name = nameController.text;
                          String roll = rollController.text;

                          if (name.isNotEmpty) {
                            url = InfixApi.getStudentByName(name);
                            Navigator.push(
                                context,
                                ScaleRoute(
                                    page: StudentSearchNameRoll(
                                  name: name,
                                  url: url,
                                )));
                          } else if (roll.isNotEmpty) {
                            url = InfixApi.getStudentByRoll(roll);
                            Navigator.push(
                                context,
                                ScaleRoute(
                                    page: StudentSearchNameRoll(
                                  roll: roll,
                                  url: url,
                                )));
                          } else {
                            url = InfixApi.getStudentByClassAndSection(
                                classId, sectionId);
                            Navigator.push(
                                context,
                                ScaleRoute(
                                    page: StudentListScreen(
                                  classCode: classId,
                                  sectionCode: sectionId,
                                  url: url,
                                  status: status,
                                )));
                          }
//
//                          if (!name.isEmpty) {
//                            Utils.showToast('$name');
//                            Navigator.push(
//                                context,
//                                ScaleRoute(
//                                    page: StudentListScreen(
//                                  name: name,
//                                )));
//                          } else if (!roll.isEmpty) {
//                            Utils.showToast('$roll');
//                            Navigator.push(
//                                context,
//                                ScaleRoute(
//                                    page: StudentListScreen(
//                                  roll: roll,
//                                )));
//                          } else {
//                            Navigator.push(
//                                context,
//                                ScaleRoute(
//                                    page: StudentListScreen(
//                                  classCode: classId,
//                                  sectionCode: sectionId,
//                                )));
//                          }
                        },
                      )
                    ],
                  );
                } else {
                  return Center(child: Text("loading..."));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getClassDropdown(List<Classes> classes) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: classes.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(item.name),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0),
        onChanged: (value) {
          setState(() {
            _selectedClass = value;

            classId = getCode(classes, value);

            debugPrint('User select $classId');
          });
        },
        value: _selectedClass,
      ),
    );
  }

  Widget getSectionDropdown(List<Section> sectionlist) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: sectionlist.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(item.name),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0),
        onChanged: (value) {
          setState(() {
            _selectedSection = value;

            sectionId = getCode(sectionlist, value);

            debugPrint('User select $sectionId');
          });
        },
        value: _selectedSection,
      ),
    );
  }

  int getCode<T>(T t, String title) {
    int code;
    for (var cls in t) {
      if (cls.name == title) {
        code = cls.id;
        break;
      }
    }
    return code;
  }

  Future<ClassList> getAllClass(int id) async {
    final response = await http.get(InfixApi.getClassById(id));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return ClassList.fromJson(jsonData['data']['teacher_classes']);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<SectionList> getAllSection(int id, int classId) async {
    final response = await http.get(InfixApi.getSectionById(id, classId));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return SectionList.fromJson(jsonData['data']['teacher_sections']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
