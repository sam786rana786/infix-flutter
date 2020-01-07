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
                    style: Theme.of(context).textTheme.display1,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF415094),
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
                    _value == null ? 'NA':_value,
                    style: Theme.of(context).textTheme.display1,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF415094),
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
