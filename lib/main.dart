import 'package:flutter/material.dart';
import 'package:infixedu/screens/SplashScreen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "infixEdu",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple
      ),
      home: Scaffold(
        body: Splash(),
      ),
    );
  }


}