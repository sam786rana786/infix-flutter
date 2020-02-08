import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/AdminBookCategory.dart';
import 'package:infixedu/utils/modal/AdminBookSubject.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAdminBook extends StatefulWidget {
  @override
  _AddAdminBookState createState() => _AddAdminBookState();
}

class _AddAdminBookState extends State<AddAdminBook> {
  var selectedCategory;
  var selectedCategoryId;
  var selectedSubject;
  var selectedSubjectId ;
  Future<AdminSubjectList> subjectList;
  Future<AdminCategoryList> categoryList;
  TextEditingController titleController = TextEditingController();
  TextEditingController bookNoController = TextEditingController();
  TextEditingController isbnNoController = TextEditingController();
  TextEditingController publisherNameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController rackNoController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subjectList = getAllSubject();
    subjectList.then((value) {
      selectedSubject = value.subjects[0].title;
      selectedSubjectId = value.subjects[0].id;
    });
    categoryList = getAllCategory();
    categoryList.then((value) {
      selectedCategory = value.categories[0].title;
      selectedSubjectId = value.categories[0].id;
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
        appBar: AppBarWidget.header(context, 'Add Book'),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder<AdminSubjectList>(
                        future: subjectList,
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return getSubjectsDropdown(snapshot.data.subjects);
                          }else{
                            return Container();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<AdminCategoryList>(
                        future: categoryList,
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return getCategoriesDropdown(snapshot.data.categories);
                          }else{
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: titleController,
                  style: Theme.of(context).textTheme.display1,
                  decoration:
                  InputDecoration(hintText: 'Enter title here'),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: bookNoController,
                        style: Theme.of(context).textTheme.display1,
                        decoration:
                        InputDecoration(hintText: 'Book number'),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: isbnNoController,
                        style: Theme.of(context).textTheme.display1,
                        decoration:
                        InputDecoration(hintText: 'ISBN'),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: publisherNameController,
                  style: Theme.of(context).textTheme.display1,
                  decoration:
                  InputDecoration(hintText: 'Publisher name'),
                ),
                TextField(
                  controller: authorController,
                  style: Theme.of(context).textTheme.display1,
                  decoration:
                  InputDecoration(hintText: 'Author name'),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: rackNoController,
                        style: Theme.of(context).textTheme.display1,
                        decoration:
                        InputDecoration(hintText: 'Rack number'),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: quantityController,
                        style: Theme.of(context).textTheme.display1,
                        decoration:
                        InputDecoration(hintText: 'Quantity'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        style: Theme.of(context).textTheme.display1,
                        decoration:
                        InputDecoration(hintText: 'Price'),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        style: Theme.of(context).textTheme.display1,
                        decoration:
                        InputDecoration(hintText: 'date'),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: descriptionController,
                  style: Theme.of(context).textTheme.display1,
                  decoration:
                  InputDecoration(hintText: 'Description'),
                ),
                Expanded(child: Container()),
                Container(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  width: double.infinity,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
//                      addFeeData(titleController.text, descripController.text).then((value){
//                        if(value){
//                          titleController.text = '';
//                          descripController.text = '';
//                        }
//                      });
                    },
                    child: new Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSubjectsDropdown(List<AdminSubject> subjects) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: subjects.map((item) {
          return DropdownMenuItem<String>(
            value: item.title,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,bottom: 10.0),
              child: Text(item.title),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
        onChanged: (value) {
          setState(() {
            //_selectedClass = value;
            selectedSubject = value;
            selectedSubjectId = getCode(subjects, value);
            debugPrint('User select $value');
          });
        },
        value: selectedSubject,
      ),
    );
  }

  Widget getCategoriesDropdown(List<Admincategory> categories) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton(
        elevation: 0,
        isExpanded: true,
        items: categories.map((item) {
          return DropdownMenuItem<String>(
            value: item.title,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,bottom: 10.0),
              child: Text(item.title),
            ),
          );
        }).toList(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0),
        onChanged: (value) {
          setState(() {
            //_selectedClass = value;
            selectedCategory = value;
            selectedCategoryId = getCode(categories, value);
            debugPrint('User select $selectedCategoryId');
          });
        },
        value: selectedCategory,
      ),
    );
  }

  int getCode<T>(T t, String title) {
    int code;
    for (var cls in t) {
      if (cls.title == title) {
        code = cls.id;
        break;
      }
    }
    return code;
  }

  Future<AdminSubjectList> getAllSubject() async {
    final response = await http.get(InfixApi.subjectList);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return AdminSubjectList.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load');
    }
  }
  Future<AdminCategoryList> getAllCategory() async {
    final response = await http.get(InfixApi.bookCategory);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return AdminCategoryList.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
