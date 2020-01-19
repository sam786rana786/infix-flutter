import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/screens/SplashScreen.dart';
import 'package:infixedu/utils/theme.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "infixEdu",
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: Scaffold(
        body: Splash(),
      ),
    );
  }

}