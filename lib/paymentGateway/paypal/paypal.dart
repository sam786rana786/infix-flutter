import 'dart:convert';
import 'package:http/http.dart' as http;
class PaypalTest{


  Future makePost() async {
    String username = "Mamun";
    String password = "01621356972";
    var bytes = utf8.encode("$username:$password");
    var credentials = base64.encode(bytes);
    Map token = {
      'grant_type': 'client_credentials'
    };

    var headers = {
      "Accept": "application/json",
      'Accept-Language': 'en_US',
      "Authorization": "Basic $credentials"
    };

    var url = "https://api.sandbox.paypal.com/v1/oauth2/token";
    var requestBody = token;
    http.Response response = await http.post(url, body: requestBody, headers: headers);
    var responseJson = json.decode(response.body);
    return responseJson;
  }

}