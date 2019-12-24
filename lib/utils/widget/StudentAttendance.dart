import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/StudentAttendance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AppBarWidget.dart';

class StudentAttendanceScreen extends StatefulWidget {
  @override
  _StudentAttendanceScreenState createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {

  int id;
  Future<StudentAttendanceList> attendances;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Utils.getStringValue('id').then((value) {
      setState(() {
        id = int.parse(value);
        DateTime date = DateTime.now();
        attendances = getAllStudentAttendance(id, date.month, date.year);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _currentDate;
    var _markedDateMap;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget.header(context, 'Attendance'),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  this.setState(() => _currentDate = date);
                },
                onCalendarChanged: (DateTime date){
                  attendances = getAllStudentAttendance(id, date.month, date.year);
                },
                weekendTextStyle: Theme.of(context).textTheme.title,
                thisMonthDayBorderColor: Colors.grey,
                daysTextStyle: Theme.of(context).textTheme.display1,


//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
              showOnlyCurrentMonthDate: false,
              headerTextStyle: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0),
                weekdayTextStyle: Theme.of(context).textTheme.display1.copyWith(fontSize: 15.0,fontWeight: FontWeight.w500),
                customDayBuilder: (   /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                    ) {
                  /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                  /// This way you can build custom containers for specific days only, leaving rest as default.

//                  if(isThisMonthDay){
//                    Utils.showToast(day.year.toString()+day.month.toString());
//
//                    attendances = getAllStudentAttendance(id, day.month, day.year);
//
//                  }

                  // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                  if (isThisMonthDay) {
                    return FutureBuilder<StudentAttendanceList>(
                      future: attendances,
                      builder: (context,snapshot){
                        if(snapshot.hasData){

                          //Utils.showToast(getAttendanceStatus(day.day, snapshot.data.attendances));

                          print('${day.day} status ${getAttendanceStatus(day.day, snapshot.data.attendances)}');

                          String status = getAttendanceStatus(day.day, snapshot.data.attendances);

                          return Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(day.day.toString(),style: Theme.of(context).textTheme.display1.copyWith(color: isToday == true ? Colors.white : Color(0xFF727FC8))),
                                  SizedBox(width: 2.0,),
                                  Container(
                                    width: 5.0,
                                    height: 5.0,
                                    decoration: BoxDecoration(
                                      color: getStatusColor(status),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(day.day.toString(),style: Theme.of(context).textTheme.display1.copyWith(color: isToday == true ? Colors.white : Color(0xFF727FC8))),
                                ],
                              ),
                            ),
                          );;
                        }
                      },
                    );
                  } else {
                    return null;
                  }
                },
                weekFormat: false,
                markedDatesMap: _markedDateMap,
                height: MediaQuery.of(context).size.height/2,
                selectedDateTime: _currentDate,
                daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              height: MediaQuery.of(context).size.height/3,
              child: ListView(
               children: <Widget>[
                 BottomDesign('Present','10 Days',Colors.green),
                 BottomDesign('Absent','10 Days',Colors.red),
                 BottomDesign('Late','10 Days',Colors.yellow),
                 BottomDesign('Halfday','10 Days',Colors.purpleAccent),
                 BottomDesign('Holiday','10 Days',Colors.deepPurpleAccent),
               ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget BottomDesign(String title,String titleVal,Color color){
    return Center(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            height: 30.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(child: Text(title,style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black45,fontWeight: FontWeight.w500),)),
          Text(titleVal,style: Theme.of(context).textTheme.headline),
        ],
      ),
    );
  }


  Future<StudentAttendanceList> getAllStudentAttendance(int id,int month,int year) async {

    debugPrint('call');

    final response = await http.get(InfixApi.getStudentAttendence(id,month,year));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return StudentAttendanceList.fromJson(jsonData['data']['attendances']);
    } else {
      throw Exception('Failed to load');
    }
  }

  String getAttendanceStatus(int date,List<StudentAttendance> attendances){
    if(date < 10){
      return getStatus(0,9,attendances,date);
    }else if(date >= 10 && date < 20){
      return getStatus(10,19,attendances,date);
    }else{
      return getStatus(0,attendances.length - 1,attendances,date);
    }
  }

  String getStatus(int i,int j, List<StudentAttendance> attendances,int date) {
    String status;
    for(int a = i ; a <= j ; a++){
      if(a < 10){
        if(AppFunction.getDay(attendances[a].date).substring(1) == date.toString()){
          status = attendances[a].type;
          break;
        }
      }else{
        if(AppFunction.getDay(attendances[a].date) == date.toString()){
          status = attendances[a].type;
          break;
      }
     }
    }
    return status;
  }

  getStatusColor(String status) {
    switch(status){
      case 'P':
        return Colors.green;
        break;
      case 'A':
        return Colors.red;
        break;
      case 'L':
        return Colors.yellow;
        break;
      case 'H':
        return Colors.purpleAccent;
        break;
      case 'F':
        return Colors.deepPurple;
        break;
      default:
        return Colors.black12;
        break;
    }
  }
}
