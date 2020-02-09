import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Classes.dart';
import 'package:infixedu/utils/modal/LibraryCategoryMember.dart';
import 'package:infixedu/utils/modal/Section.dart';
import 'package:infixedu/utils/modal/Student.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/Line.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {

  final idController = TextEditingController();
  String selectedCategory;
  Future<LibraryMemberList> categoryList;
  Future<ClassList> classes;
  Future<SectionList> sections;
  Future<StudentList> students;
  int selectedCategoryId;
  bool isStudentCategory = false;
  String selectedClass;
  int selectedClassId;
  String selectedSection;
  int selectedSectionId;
  String selectedStudent;
  int selectedStudentId;
  String _id;


  @override
  void initState() {
    super.initState();

    categoryList = getAllCategory();

    categoryList.then((value) {
      selectedCategory = value.members[0].name;
      selectedCategoryId = value.members[0].id;
    });
    Utils.getStringValue('id').then((value) {
      setState(() {
        _id = value;
        classes = getAllClass(int.parse(_id));
        classes.then((value) {
          selectedClass = value.classes[0].name;
          selectedClassId = value.classes[0].id;
          sections = getAllSection(int.parse(_id), selectedClassId);
          sections.then((sectionValue) {
            selectedSection = sectionValue.sections[0].name;
            selectedSectionId = sectionValue.sections[0].id;
            students = getAllStudent();
            students.then((value) {
              selectedStudent = value.students[0].name;
              selectedStudentId = value.students[0].id;

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
        appBar: AppBarWidget.header(context, 'Add Member'),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: idController,
                  style: Theme.of(context).textTheme.display1,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Enter ID Here',border: InputBorder.none,),
                ),
              ),
              FutureBuilder<LibraryMemberList>(
                future: categoryList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getCategoryDropdown(
                        snapshot.data.members);
                  } else {
                    return Container();
                  }
                },
              ),
              FutureBuilder<ClassList>(
                future: classes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return isStudentCategory ? getClassDropdown(
                        snapshot.data.classes):Container();
                  } else {
                    return Container();
                  }
                },
              ),
              FutureBuilder<SectionList>(
                future: sections,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return isStudentCategory ? getSectionDropdown(
                        snapshot.data.sections):Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
//
//  Widget getClassDropdown(List<String> classes) {
//    return Container(
//      width: MediaQuery.of(context).size.width,
//      child: DropdownButton(
//        elevation: 0,
//        isExpanded: true,
//        items: classes.map((item) {
//          return DropdownMenuItem<String>(
//            value: item,
//            child: Padding(
//              padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
//              child: Text(item),
//            ),
//          );
//        }).toList(),
//        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
//        onChanged: (value) {
////          setState(() {
////            selectedCategory = value;
////            selectedCategoryId = getCode(categories, value);
////            switch(selectedCategoryId){
////              case 2:
////                setState(() {
////                  isStudentCategory = true;
////                });
////                break;
////              default :
////                setState(() {
////                  isStudentCategory = false;
////                });
////                break;
////            }
////            debugPrint('User select $selectedCategoryId');
////          });
//        },
//        value: selectedClass,
//      ),
//    );
//  }
//
//  Widget getSectionDropdown(List<String> sections) {
//    return Container(
//      width: MediaQuery.of(context).size.width,
//      child: DropdownButton(
//        elevation: 0,
//        isExpanded: true,
//        items: sections.map((item) {
//          return DropdownMenuItem<String>(
//            value: item,
//            child: Padding(
//              padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
//              child: Text(item),
//            ),
//          );
//        }).toList(),
//        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
//        onChanged: (value) {
////          setState(() {
////            selectedCategory = value;
////            selectedCategoryId = getCode(categories, value);
////            switch(selectedCategoryId){
////              case 2:
////                setState(() {
////                  isStudentCategory = true;
////                });
////                break;
////              default :
////                setState(() {
////                  isStudentCategory = false;
////                });
////                break;
////            }
////            debugPrint('User select $selectedCategoryId');
////          });
//        },
//        value: selectedSection,
//      ),
//    );
//  }

  Widget getCategoryDropdown(List<LibraryMember> categories) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: categories.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
              child: Text(item.name),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
            selectedCategoryId = getCode(categories, value);
            switch(selectedCategoryId){
              case 2:
                setState(() {
                  isStudentCategory = true;
                });
                break;
              default :
                setState(() {
                  isStudentCategory = false;
                });
                break;
            }
            debugPrint('User select $selectedCategoryId');
          });
        },
        value: selectedCategory,
      ),
    );
  }

  Widget getClassDropdown(List<Classes> classes) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: classes.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
              child: Text(item.name),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
        onChanged: (value) {
          setState(() {
            selectedClass = value;
            selectedClassId = getCode(classes, value);
            debugPrint('User select $selectedClassId');
          });
        },
        value: selectedClass,
      ),
    );
  }

  Widget getSectionDropdown(List<Section> sections) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: sections.map((item) {
          return DropdownMenuItem<String>(
            value: item.name,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
              child: Text(item.name),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
        onChanged: (value) {
          setState(() {
            selectedSection = value;
            selectedSectionId = getCode(sections, value);
            students = getAllStudent();
            debugPrint('User select $selectedSectionId');
          });
        },
        value: selectedSection,
      ),
    );
  }

  Future<LibraryMemberList> getAllCategory() async {
    final response = await http.get(InfixApi.getLibraryMemberCategory);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return LibraryMemberList.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load');
    }
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

  Future<SectionList> getAllSection(int id, int classId) async {
    final response = await http.get(InfixApi.getSectionById(id, classId));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return SectionList.fromJson(jsonData['data']['teacher_sections']);
    } else {
      throw Exception('Failed to load');
    }
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

  Future<StudentList> getAllStudent() async {
    final response = await http.get(InfixApi.getStudentByClassAndSection(
        selectedClassId, selectedSectionId));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return StudentList.fromJson(jsonData['data']['students']);
    } else {
      throw Exception('Failed to load');
    }
  }

}
