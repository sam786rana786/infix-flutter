import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/modal/InfixMap.dart';
import 'package:infixedu/utils/apis/Apis.dart';

class ProfileService {
  String _email;
  String _password;
  ProfileService(this._email,this._password);

  List<InfixMap> infixMap = List();

  Future<List<InfixMap>> fetchPersonalServices() async {

    infixMap.clear();

    final response = await http.get(InfixApi.login(_email, _password));

    var jsonData = json.decode(response.body);

    var details = jsonData['data']['userDetails'];
    var religion = jsonData['data']['religion'];
    var blood = jsonData['data']['blood_group'];

    infixMap.add(InfixMap('Date of Birth',details['date_of_birth']));
    infixMap.add(InfixMap('Religion',religion['name']));
    infixMap.add(InfixMap('Phone Number',details['mobile']));
    infixMap.add(InfixMap('Email Address',details['email']));
    infixMap.add(InfixMap('Present Address',details['current_address']));
    infixMap.add(InfixMap('Parmanent Address',details['permanent_address']));
    infixMap.add(InfixMap('Father\'s Name',details['fathers_name']));
    infixMap.add(InfixMap('Mother\'s Name',details['mothers_name']));
    infixMap.add(InfixMap('Blood Group',blood['name']));

    //Utils.showToast(infixMap[0].key+' '+infixMap[0].value);

    return infixMap;
  }



}