import 'package:flutter/material.dart';
import 'package:infixedu/utils/server/Login.dart';
import 'package:infixedu/utils/apis/Apis.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/login_bg.png'),
                      fit: BoxFit.fill,
                    )),
                    child: Center(
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('images/inflex_edu_logo.png'),
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: emailController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter a valid email';
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "email",
                                labelText: "Email",
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.pinkAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: passwordController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter a valid password';
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "password",
                                labelText: "Password",
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.pinkAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.purple,
                            ),
                            child: Text(
                                "Login",
                                style: Theme.of(context).textTheme.display1,
                              ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {

                                String email = emailController.text;
                                String email1 = emailController.text;
                                String password = passwordController.text;

                                Login(InfixApi.login(email, password)).getData(context).then((result)=>{
                                  if(result){
                                    debugPrint('success')
                                  }
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
