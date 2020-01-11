import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import './Login.dart';
import './Home.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{

  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    Route route;

    controller = AnimationController(duration: Duration(seconds: 3),vsync: this);
    animation = Tween(begin: 30.0,end:90.0).animate(controller);
    controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      getBooleanValue('isLogged').then((value) {
        if (value) {
//        route = MaterialPageRoute(builder: (context) => Home());
          Utils.getStringValue('rule').then((rule) {
            AppFunction.getFunctions(context , rule);
          });
        }else {
          route = MaterialPageRoute(builder: (context) => LoginScreen());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/splash_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    height: 10.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/line.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'Welcome to',
                            style: TextStyle(
                              color: Color(0xFF727FC8),
                              fontSize: 20.0,
                              fontFamily: 'popins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animation,
                          builder: (context,child){
                            return Container(
                              height: animation.value,
                              width: animation.value,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage('images/splash_logo.png'),
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60.0),
                          child: Text(
                            'UNLIMITED EDUCATION ERP',
                            style: TextStyle(
                                color: Color(0xFF727FC8),
                                fontSize: 10.0,
                                fontFamily: 'popins',
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 80.0, left: 40, right: 40),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> getBooleanValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
