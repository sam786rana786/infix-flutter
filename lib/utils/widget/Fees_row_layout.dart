import 'package:flutter/material.dart';
import 'package:infixedu/utils/Utils.dart';


class Fees_row extends StatelessWidget {
//  Fee fee;
//  Fees_row(this.fee);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Educational materials',
                  style: Theme.of(context).textTheme.headline,
                  maxLines: 1,
                ),
              ),
              Container(
                width: 80.0,
                child: GestureDetector(
                  onTap: (){
                    showAlertDialog(context);
                  },
                  child: Text(
                    'View',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headline.copyWith(color: Colors.deepPurpleAccent,decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Due Date',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        '2019-08-24',
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
                        'Amount',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
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
                        'Paid',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
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
                        'Balance',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
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
                        'Status',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                          child: Text(
                            'paid',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.purple, Colors.deepPurple]),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Educational materials',
                              style: Theme.of(context).textTheme.headline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
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
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );

  }

}