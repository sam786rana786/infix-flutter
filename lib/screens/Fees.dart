import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/widget/Fees_row_layout.dart';
import 'package:infixedu/utils/widget/AppBarWidget.dart';
import 'package:flutter/services.dart';

class Fees_screen extends StatefulWidget {
  @override
  _Fees_screenState createState() => _Fees_screenState();
}

class _Fees_screenState extends State<Fees_screen> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Fees'),
        backgroundColor: Colors.white,
        body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Grand Total',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 20.0),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10.0,bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Amount',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$5000',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Discount',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$350',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Fine',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$280',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Paid',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$250',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Balance',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$85200',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .display1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 15.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xfff3e5f5).withOpacity(0.5), Colors.white]),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context,index){
                      return Fees_row();
                    },
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
