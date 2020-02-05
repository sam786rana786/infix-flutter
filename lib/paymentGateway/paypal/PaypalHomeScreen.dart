import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:infixedu/paymentGateway/paytm/PaymentStatusScreen.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/Fee.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';
import 'package:infixedu/utils/widget/fees_payment_row_widget.dart';

class PayPalPayment extends StatefulWidget {
  Fee fee;
  String id;
  String amount;
  String apiUrl = 'http://192.168.1.113:3000/';

  PayPalPayment(this.fee, this.amount,this.id);

  _PayPalPaymentState createState() => _PayPalPaymentState(amount);
}

class _PayPalPaymentState extends State<PayPalPayment> {
  String amount;

  _PayPalPaymentState(this.amount);

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  var isCompleted = false;

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      //print("onStateChanged: ${state.type} ${state.url}");
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        //print("URL changed: $url");
        if (url.contains('success')) {
          isPaymentSuccesful().then((value) {
            if (value) {
              setState(() {
                isCompleted = true;
                _onDestroy.cancel();
                _onUrlChanged.cancel();
                _onStateChanged.cancel();
                flutterWebviewPlugin.dispose();
              });
            }
          });
        } else {
          setState(() {
            isCompleted = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryParams = '?name=${widget.fee.title}&amount=${widget.amount}&currency=INR';

    //print(Settings.apiUrl);

    return isCompleted
        ? PaymentStatusScreen(widget.fee, amount)
        : WebviewScaffold(
            url: widget.apiUrl + queryParams,
            appBar: new AppBar(
              title: new Text("Pay using Paypal"),
            ));
  }

  Future<bool> isPaymentSuccesful() async {
    final response = await http
        .get(InfixApi.studentFeePayment(widget.id, widget.fee.id, amount, widget.id, 'C'));
    var jsonData = json.decode(response.body);
    return jsonData['success'];
  }
}

class AddPaypalAmount extends StatelessWidget {
  Fee fee;
  String id;
  String amount;
  TextEditingController amountController = TextEditingController();

  AddPaypalAmount(this.fee,this.id) {
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
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        ScaleRoute(
                            page: PayPalPayment(fee,
                                '${absoluteAmount(amountController.text)}',id)));
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

  int absoluteAmount(String am) {
    int amount = int.parse(am);
    if (amount < 0) {
      return -amount;
    } else {
      return amount;
    }
  }
}
