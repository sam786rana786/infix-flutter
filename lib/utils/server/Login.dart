import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infixedu/screens/Home.dart';

class Login {
  final String url;
  Login(this.url);

  Future<bool> getData(BuildContext context) async {
    bool isSuccessed;
    print('Calling uri: $url');
    Response response = await get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body) as Map;
      isSuccessed = user['success'];
      if(isSuccessed){
                                Route route = MaterialPageRoute(builder: (context) => Home());
                                Navigator.pushReplacement(context, route);
      }
    }
    return isSuccessed;
  }
}
