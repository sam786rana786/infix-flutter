import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infixedu/screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infixedu/utils/apis/Apis.dart';

class Login {
  final String email;
  final String password;

  Login(this.email,this.password);

  Future<bool> getData(BuildContext context) async {
    bool isSuccessed;
    String id;
    String rule;
    Response response = await get(InfixApi.login(email, password));
    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body) as Map;
      isSuccessed = user['success'];
      id = user['data']['user']['id'];
      rule = user['data']['user']['role_id'];
      if (isSuccessed) {
        saveBooleanValue('isLogged', isSuccessed);
        saveStringValue('email', email);
        saveStringValue('password', password);
        saveStringValue('id', id);
        saveStringValue('rule', rule);
        Route route = MaterialPageRoute(builder: (context) => Home());
        Navigator.pushReplacement(context, route);
      }
    }
    return isSuccessed;
  }

  Future<bool> saveBooleanValue(String key ,bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }

  Future<bool> saveStringValue(String key ,String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

}
