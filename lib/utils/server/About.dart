import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/InfixMap.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class About {
  List<InfixMap> infixMap = List();

  Future<List<InfixMap>> fetchAboutServices() async {
    infixMap.clear();

    final response = await http.get(InfixApi.ABOUT);

    var jsonData = json.decode(response.body);

    var data = jsonData['data'];

    infixMap.add(InfixMap('Description', data['main_description']));
    infixMap.add(InfixMap('Address', data['address']));
    infixMap.add(InfixMap('Phone', data['phone']));
    infixMap.add(InfixMap('Email', data['email']));
    infixMap.add(InfixMap('School Code', data['school_code']));
    infixMap.add(InfixMap('Session', data['session']));

    return infixMap;
  }
}
