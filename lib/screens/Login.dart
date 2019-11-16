import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen(context),
    );
  }
}

Widget screen(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextStyle textStyle = Theme.of(context).textTheme.title;

  return Container(
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
          Expanded(
            child: Container(
              alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
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
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
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
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                  ],
                ),
            ),
          )
        ],
      ),
    );
}
