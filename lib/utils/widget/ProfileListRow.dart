import 'package:flutter/material.dart';

class Profile_row_list extends StatelessWidget {

  String _key;
  String _value;

  Profile_row_list(this._key,this._value);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _key,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'popins',
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF727FC8)),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _value,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'popins',
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF727FC8)),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
