import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
//        localizationsDelegates: [
//          GlobalMaterialLocalizations.delegate,
//          GlobalWidgetsLocalizations.delegate,
//          GlobalCupertinoLocalizations.delegate,
//        ],
//        supportedLocales: [
//        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
//    ],
    );
  }

}