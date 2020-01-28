import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/modal/Fee.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';
import 'package:infixedu/paymentGateway/paytm/PaytmHomeScreen.dart';
import 'package:infixedu/utils/widget/fees_payment_row_widget.dart';
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, ScaleRoute(page: AddAmount(widget.fee)));
              },
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.black12,
                    child: Image.asset('images/paytm.png'),
                  ),
                  title: Text(
                    'Paytm',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, ScaleRoute(page: GooglePayScreen(widget.fee)));
              },
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.greenAccent,
                    child: Image.asset('images/googleplay.png'),
                  ),
                  title: Text(
                    'GPay',
                    style: Theme.of(context).textTheme.headline.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.redAccent),
                  ),
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
                title: Text(
                  'Phonepe',
                  style: Theme.of(context).textTheme.headline.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.deepPurple),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddAmount extends StatelessWidget {
  Fee fee;
  String amount;
  TextEditingController amountController = TextEditingController();

  AddAmount(this.fee);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    amount = fee.balance;
    amountController.text = amount;

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Amount'),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Fees_payment_row(fee),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.title,
                  controller: amountController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'please enter a valid amount';
                    }
                    return value;
                  },
                  decoration: InputDecoration(
                      hintText: "amount",
                      labelText: "amount",
                      labelStyle: Theme.of(context).textTheme.display1,
                      errorStyle:
                          TextStyle(color: Colors.pinkAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, ScaleRoute(page: PaytmPayment(fee,amountController.text)));
                  },
                  color: Colors.purpleAccent,
                  textColor: Colors.white,
                  child: Text(
                    "Enter amount",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
