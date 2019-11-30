import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/modal/InfixMap.dart';
import 'package:infixedu/utils/apis/Apis.dart';

class ProfileService {
  String _email;
  String _password;
  ProfileService(this._email,this._password);

  List<InfixMap> infixMap = List();

  Future<List<InfixMap>> fetchPersonalServices() async {

    final response = await http.get(InfixApi.login(_email, _password));

    var jsonData = json.decode(response.body);

    print(jsonData);

    return infixMap;
  }



}