import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Classes.dart';
import 'package:infixedu/utils/modal/Section.dart';
import 'package:infixedu/utils/modal/TeacherSubject.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AddHomeworkScrren extends StatefulWidget {
  @override
  _AddHomeworkScrrenState createState() => _AddHomeworkScrrenState();
}

class _AddHomeworkScrrenState extends State<AddHomeworkScrren> {

  String _id;
  int classId;
  int subjectId;
  int sectionId;
  String _selectedClass;
  String _selectedSection;
  String _selectedSubject;
  TextEditingController markController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Future<ClassList> classes;
  Future<SectionList> sections;
  Future<TeacherSubjectList> subjects;
  TeacherSubjectList subjectList;


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
            _selectedSection = sectionValue.Sections[0].name;
            sectionId = sectionValue.Sections[0].id;
            subjects = getAllSubject(int.parse(_id));
            subjects.then((subVal){
              setState(() {
                subjectList = subVal;
                subjectId = subVal.subjects[0].subjectId;
                _selectedSubject = subVal.subjects[0].subjectName;
              });
            });
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
        appBar: AppBarWidget.header(context, 'Add Homework'),
        backgroundColor: Colors.white,
        body: Container(
          child: getContent(context),
        ),
      ),
    );
  }

  Widget getContent(BuildContext context){
    return Container(
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
                      return getSectionDropdown(secSnap.data.Sections);
                    } else {
                      return Center(child: Text("loading..."));
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder<TeacherSubjectList>(
                  future: subjects,
                  builder: (context, subSnap) {
                    if (subSnap.hasData) {
                      return getSubjectDropdown(subSnap.data.subjects);
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
                    controller: markController,
                    decoration: InputDecoration(
                        hintText: "Mark",
                        labelText: "Mark",
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
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: "Description",
                        labelText: "Description",
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
                        "Save",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(
                            color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  onTap: () {
                    String mark = markController.text;
                    String description = descriptionController.text;

                    if (mark.isNotEmpty) {


                    } else if (description.isNotEmpty) {


                    } else {


                    }
                  },
                )
              ],
            );
          } else {
            return Center(child: Text("loading..."));
          }
        },
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

  Widget getSubjectDropdown(List<teacherSubject> subjectList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: subjectList.map((item) {
          return DropdownMenuItem<String>(
            value: item.subjectName,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(item.subjectName),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0),
        onChanged: (value) {
          setState(() {
            _selectedSubject = value;
            //sectionId = getCode(sectionlist, value);

            debugPrint('User select $subjectId');
          });
        },
        value: _selectedSubject,
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

  Future<TeacherSubjectList> getAllSubject(int id) async {
    final response = await http.get(InfixApi.getTeacherSubject(id));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return TeacherSubjectList.fromJson(jsonData['data']['subjectsName']);
    } else {
      throw Exception('Failed to load');
    }
  }
  int getSubjectId<T>(T t,String subject){
    int code;
    for(var s in t){
      if(s.subjectName == subject){
         code = s.subjectId;
      }
    }
    return code;
  }
}
