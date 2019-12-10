import 'package:flutter/material.dart';

class Student_homework_row extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Bangla',
                    style: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0),
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 80.0,
                  child: GestureDetector(
                    onTap: (){
                      //showAlertDialog(context);
                    },
                    child: Text(
                      'download',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.title.copyWith(color: Colors.deepPurpleAccent,decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                Container(
                  width: 80.0,
                  child: GestureDetector(
                    onTap: (){
                      //showAlertDialog(context);
                    },
                    child: Text(
                      'view',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.title.copyWith(color: Colors.deepPurpleAccent,decoration: TextDecoration.underline),
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
                          'Created',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          '2019-09-24',
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
                          'Submission',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          '2019-09.30',
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
                          'Evaluation',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          '2019-12-25',
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
                        //getStatus(context),
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
      ),
    );
  }
}
