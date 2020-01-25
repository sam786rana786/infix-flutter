import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/modal/Fee.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

import 'GooglePayScreen.dart';

class PaymentHome extends StatefulWidget {

  Fee fee;
  PaymentHome(this.fee);

  @override
  _PaymentHomeState createState() => _PaymentHomeState();
}

class _PaymentHomeState extends State<PaymentHome> {

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Payment'),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.black12,
                  child: Image.asset('images/paytm.png'),
                ),
                title: Text('Paytm',style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w700,fontSize: 18),),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, ScaleRoute(page: GooglePayScreen(widget.fee)));
              },
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.greenAccent,
                    child: Image.asset('images/googleplay.png'),
                  ),
                  title: Text('GPay',style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.redAccent),),
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Image.asset('images/phonepe.jpg'),
                ),
                title: Text('Phonepe',style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.deepPurple),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
