import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Classes.dart';
import 'package:infixedu/utils/modal/Section.dart';
import 'package:infixedu/utils/modal/TeacherSubject.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:permissions_plugin/permissions_plugin.dart';

class AddContentScreeen extends StatefulWidget {
  @override
  _AddContentScreeenState createState() => _AddContentScreeenState();
}

class _AddContentScreeenState extends State<AddContentScreeen> {
  String _id;
  int classId;
  int subjectId;
  int sectionId;
  String _selectedClass;
  String _selectedSection;
  String _selectedContentType;
  String _selectedaAssignDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Future<ClassList> classes;
  Future<SectionList> sections;
  Future<TeacherSubjectList> subjects;
  TeacherSubjectList subjectList;
  DateTime date;
  String maxDateTime = '2031-11-25';
  String initDateTime = '2019-05-17';
  String _format;
  DateTime _dateTime;
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  File _file;
  bool isResponse = false;
  Response response;
  Dio dio = new Dio();
  var contentType = [
    'assignment',
    'study material',
    'syllabus',
    'other download'
  ];
  String radioStr = 'admin';
  int allClasses = 0;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    initDateTime =
        '${date.year}-${getAbsoluteDate(date.month)}-${getAbsoluteDate(date.day)}';
    _dateTime = DateTime.parse(initDateTime);


    checkPermissions(context);
    Utils.getStringValue('id').then((value) {
      setState(() {
        _id = value;
        classes = getAllClass(int.parse(_id));
        classes.then((value) {
          _selectedClass = value.classes[0].name;
          classId = value.classes[0].id;
          _selectedContentType = 'assignment';
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
        appBar: AppBarWidget.header(context, 'Add Content'),
        backgroundColor: Colors.white,
        body: Container(
          child: getContent(context),
        ),
      ),
    );
  }

  Widget getContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder<ClassList>(
            future: classes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    getContentTypeDropdown(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.display1,
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: "Title",
                            labelText: "Title",
                            labelStyle: Theme.of(context).textTheme.display1,
                            errorStyle: TextStyle(
                                color: Colors.pinkAccent, fontSize: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Available for',
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 15.0),
                      ),
                    ),
                    RadioListTile(
                      groupValue: radioStr,
                      title: Text("All Admin",style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontSize: 15.0)),
                      value: 'admin',
                      onChanged: (val) {
                        setState(() {
                          radioStr = val;
                        });
                      },
                      activeColor: Colors.purple,
                      selected: true,
                      dense: true,
                    ),
                    RadioListTile(
                      groupValue: radioStr,
                      title: Text("Student",style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontSize: 15.0)),
                      value: 'student',
                      onChanged: (val) {
                        setState(() {
                          radioStr = val;
                          showAlertDialog(context);
                        });
                      },
                      activeColor: Colors.purple,
                      dense: true,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          pickerTheme: DateTimePickerTheme(
                            confirm: Text('Done',
                                style: TextStyle(color: Colors.red)),
                            cancel: Text('cancel',
                                style: TextStyle(color: Colors.cyan)),
                          ),
                          minDateTime: DateTime.parse(initDateTime),
                          maxDateTime: DateTime.parse(maxDateTime),
                          initialDateTime: _dateTime,
                          dateFormat: _format,
                          locale: _locale,
                          onClose: () => print("----- onClose -----"),
                          onCancel: () => print('onCancel'),
                          onChange: (dateTime, List<int> index) {
                            setState(() {
                              _dateTime = dateTime;
                            });
                          },
                          onConfirm: (dateTime, List<int> index) {
                            setState(() {
                              setState(() {
                                _dateTime = dateTime;
                                print(
                                    '${_dateTime.year}-0${_dateTime.month}-${_dateTime.day}');
                                _selectedaAssignDate =
                                    '${_dateTime.year}-${getAbsoluteDate(_dateTime.month)}-${getAbsoluteDate(_dateTime.day)}';
                              });
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Text(
                                  _selectedaAssignDate == null
                                      ? 'Assign Date'
                                      : _selectedaAssignDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(fontSize: 15.0),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black12,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        pickDocument();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  _file == null ? 'Select file' : _file.path,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(fontSize: 15.0),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            Text('Browse',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        decoration: TextDecoration.underline)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
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
                  ],
                );
              } else {
                return Center(child: Text("loading..."));
              }
            },
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(10.0),
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
                    .copyWith(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          onTap: () {
            String title = titleController.text;
            String description = descriptionController.text;

            if(title.isNotEmpty && description.isNotEmpty && _file.path.isNotEmpty){
              setState(() {
                isResponse = true;
              });
              uploadContent();
            }else{
              Utils.showToast('Check all the field');
            }
          },
        ),
        isResponse == true
            ? LinearProgressIndicator(
                backgroundColor: Colors.transparent,
              )
            : Text(''),
      ],
    );
  }

  Widget getContentTypeDropdown() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: contentType.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(item),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0),
        onChanged: (value) {
          setState(() {
            _selectedContentType = value;
            debugPrint('User select $_selectedContentType');
          });
        },
        value: _selectedContentType,
      ),
    );
  }

  void uploadContent() async{
    FormData formData = FormData.fromMap({
      "class": '$classId',
      "section": '$sectionId',
      "upload_date": _selectedaAssignDate,
      "available_for": radioStr,
      "description": descriptionController.text,
      "created_by": '$_id',
      "all_classes": '$allClasses',
      "content_title": titleController.text,
      "content_type": _selectedContentType.substring(0,2),
      "attach_file": await MultipartFile.fromFile(_file.path),
    });
    response = await dio.post(InfixApi.uploadContent, data: formData);

    if(response.statusCode == 200){
      Utils.showToast('Upload successful');
      Navigator.pop(context);
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

  showAlertDialog(BuildContext context)   {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        body: FutureBuilder<ClassList>(
                          future: classes,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView(
                                children: <Widget>[

                                  GestureDetector(
                                    child: RadioListTile(
                                      groupValue: allClasses,
                                      title: Text("All Student",style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(fontSize: 15.0)),
                                      value: 1,
                                      onChanged: (val) {
                                        setState(() {
                                          allClasses = val;
                                        });
                                      },
                                      activeColor: Colors.purple,
                                    ),
                                    onTap: (){
                                      setState(() {
                                        if(allClasses==0){
                                          allClasses = 1;
                                        }else{
                                          allClasses = 0;
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: DropdownButton(
                                      elevation: 0,
                                      isExpanded: true,
                                      items: snapshot.data.classes.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(item.name),
                                          ),
                                        );
                                      }).toList(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(fontSize: 15.0),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedClass = value;
                                          classId = getCode(
                                              snapshot.data.classes, value);
                                          debugPrint('User select $classId');
                                        });
                                      },
                                      value: _selectedClass,
                                    ),
                                  ),
                                  FutureBuilder<SectionList>(
                                    future: sections,
                                    builder: (context, secSnap) {
                                      if (secSnap.hasData) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: DropdownButton(
                                            elevation: 0,
                                            isExpanded: true,
                                            items: secSnap.data.sections
                                                .map((item) {
                                              return DropdownMenuItem<String>(
                                                value: item.name,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(item.name),
                                                ),
                                              );
                                            }).toList(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1
                                                .copyWith(fontSize: 15.0),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedSection = value;

                                                sectionId = getCode(
                                                    secSnap.data.sections,
                                                    value);

                                                debugPrint(
                                                    'User select $sectionId');
                                              });
                                            },
                                            value: _selectedSection,
                                          ),
                                        );
                                      } else {
                                        return Center(
                                            child: Text("loading..."));
                                      }
                                    },
                                  ),
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
                )
              ],
            );
          },
        );
      },
    );
  }

  String getAbsoluteDate(int date) {
    return date < 10 ? '0$date' : '$date';
  }

  Future pickDocument() async {
    File file = await FilePicker.getFile();
    setState(() {
      _file = file;
    });
  }

  Future<void> checkPermissions(BuildContext context) async {
//
//    final PermissionState aks = await PermissionsPlugin.isIgnoreBatteryOptimization;
//
//    PermissionState resBattery;
//    if(aks != PermissionState.GRANTED)
//      resBattery = await PermissionsPlugin.requestIgnoreBatteryOptimization;

//    print(resBattery);

    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.checkPermissions([
      Permission.READ_EXTERNAL_STORAGE,
    ]);

    if (permission[Permission.READ_EXTERNAL_STORAGE] !=
        PermissionState.GRANTED) {
      try {
        permission = await PermissionsPlugin.requestPermissions([
          Permission.READ_EXTERNAL_STORAGE,
        ]);
      } on Exception {
        debugPrint("Error");
      }

      if (permission[Permission.READ_EXTERNAL_STORAGE] ==
          PermissionState.GRANTED)
        print(" permission ok");
      else
        permissionsDenied(context);
    } else {
      print("permission ok");
    }
  }

  void permissionsDenied(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return SimpleDialog(
            title: const Text("Permission denied"),
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                child: const Text(
                  "You must grant all permission to use this application",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            ],
          );
        });
  }
}
