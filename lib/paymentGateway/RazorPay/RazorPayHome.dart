import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/modal/Fee.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';
import 'package:infixedu/utils/widget/cookie_button.dart';
import 'package:infixedu/utils/widget/fees_payment_row_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../PaymentHome.dart';

class RazorPayment extends StatefulWidget {
  Fee fee;

  RazorPayment(this.fee);

  @override
  _RazorPaymentState createState() => _RazorPaymentState();
}

class _RazorPaymentState extends State<RazorPayment> {
  static const platform = const MethodChannel("razorpay_flutter");

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Razor Payment'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Fees_payment_row(widget.fee),
            ),
            Container(
              child: Image(image: AssetImage("images/about.png")),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Check your amount of fee  \nwhen you make payment",
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, ScaleRoute(page: AddRazorAmount(widget.fee)));
                },
                child: Container(
                  height: 40.0,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Make Payment',
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(color: Colors.white),
                    ),
                  ),
//                onPressed: openCheckout,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddRazorAmount extends StatefulWidget {
  Fee fee;

  AddRazorAmount(this.fee);

  @override
  _AddRazorAmountState createState() => _AddRazorAmountState(fee);
}

class _AddRazorAmountState extends State<AddRazorAmount> {
  Fee fee;
  String amount;
  TextEditingController amountController = TextEditingController();
  Razorpay _razorpay;

  _AddRazorAmountState(this.fee) {
    amount = '${absoluteAmount(fee.balance)}';
    amountController.text = amount;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

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
                child: GestureDetector(
                  onTap: (){
                    openCheckout(amountController.text);
                  },
                  child: Container(
                    height: 40.0,
                    color: Colors.purpleAccent,
                    child: Center(
                      child: Text(
                        "Enter amount",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(color: Colors.white,fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String am) async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': '${int.parse(am)*100}',
      'currency':'INR',
      'name': 'Mamun Hossain',
      'description': 'Fine Payment',
      'prefill': {'contact': '01903273865', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      },
      "theme": {
        "color": "#415094"
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  int absoluteAmount(String am) {
    int amount = int.parse(am);
    if (amount < 0) {
      return -amount;
    } else {
      return amount;
    }
  }
}
