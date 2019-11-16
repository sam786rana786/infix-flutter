import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {

  String text;
  CardItem({this.text});

  @override
  _CardItemState createState() => _CardItemState(text: text);
}

class _CardItemState extends State<CardItem> {

  String text;
  bool isTapped;
  _CardItemState({this.text});

  @override
  void initState() {
    super.initState();
    isTapped = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: (){
            debugPrint(text);
            setState(() {
              isTapped = true;
            });
          },
          child: Container(
            height: 100.0,
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: isTapped ? Color(0xffe1bee7) : Color(0xfff3e5f5),
                blurRadius: 20.0,
              ),
            ]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: isTapped ? Colors.purpleAccent : Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ListView(
                  children: <Widget>[
                    Icon(Icons.access_time,color: isTapped ? Colors.white : Colors.grey,),
                    SizedBox(height: 5.0,),
                    Text(text,style: TextStyle(color: isTapped ? Colors.white : Colors.grey,fontSize: 12.0,),maxLines: 1,textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

