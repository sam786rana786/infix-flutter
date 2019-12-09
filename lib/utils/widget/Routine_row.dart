import 'package:flutter/material.dart';

class RoutineRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0,left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Text('Saturday',style:Theme.of(context).textTheme.title.copyWith(fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child:  Text('Time',style:Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                ),
                Expanded(
                  child:  Text('Subject',style:Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                ),
                Expanded(
                  child:  Text('Room',style:Theme.of(context).textTheme.display1.copyWith(fontSize: 13.0)),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child:  Text('9.0 AM -10.0 AM',style:Theme.of(context).textTheme.display1),
              ),
              Expanded(
                child:  Text('Bangla',style:Theme.of(context).textTheme.display1),
              ),
              Expanded(
                child:  Text('room - 101',style:Theme.of(context).textTheme.display1),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child:  Text('10.0 AM - 10.0 AM',style:Theme.of(context).textTheme.display1),
              ),
              Expanded(
                child:  Text('English',style:Theme.of(context).textTheme.display1),
              ),
              Expanded(
                child:  Text('room - 103',style:Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
