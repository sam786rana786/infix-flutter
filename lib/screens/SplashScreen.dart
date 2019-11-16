import 'package:flutter/material.dart';
import 'dart:async';
import './Login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>{

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 3),(){
      Route route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushReplacement(context, route);
     }
    );
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
                        Container(
                          height: 60.0,
                          width: 90.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('images/splash_logo.png'),
                            ),
                          ),
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
                      padding: const EdgeInsets.only(bottom: 80.0,left: 40,right: 40),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.purple,
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

//  getImageFromAsset(){
//    AssetImage asset_image = AssetImage("images/splashIcon.jpg");
//    Image image = Image(image: asset_image,width: 400,);
//    return Container(child: image,padding: EdgeInsets.all(20.0),);
//  }
}
