import 'package:flutter/material.dart';

//class CardItem extends StatefulWidget {
//
//  String text;
//  CardItem({this.text});
//
//  @override
//  _CardItemState createState() => _CardItemState(text: text);
//}
//
//class _CardItemState extends State<CardItem> {
//
//  String text;
//  bool isTapped;
//  _CardItemState({this.text});
//
//  @override
//  void initState() {
//    super.initState();
//    isTapped = false;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      body: Padding(
//        padding: const EdgeInsets.all(5.0),
//        child: GestureDetector(
//          onTap: (){
//            debugPrint(text);
//            setState(() {
//              isTapped = true;
//            });
//          },
//          child: Container(
//            height: 100.0,
//            decoration: new BoxDecoration(boxShadow: [
//              new BoxShadow(
//                color: isTapped ? Color(0xffe1bee7) : Color(0xfff3e5f5),
//                blurRadius: 20.0,
//              ),
//            ]),
//            child: Card(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(5.0),
//              ),
//              color: isTapped ? Colors.purpleAccent : Colors.white,
//              elevation: 0,
//              child: Padding(
//                padding: const EdgeInsets.only(top: 40.0),
//                child: ListView(
//                  children: <Widget>[
//                    Icon(Icons.access_time,color: isTapped ? Colors.white : Colors.grey,),
//                    SizedBox(height: 5.0,),
//                    Text(text,style: TextStyle(color: isTapped ? Colors.white : Colors.grey,fontSize: 12.0,),maxLines: 1,textAlign: TextAlign.center,)
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

class CustomWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final String headline;
  final IconData icon;

  const CustomWidget({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    @required this.headline,
    @required this.icon,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
      height: 100.0,
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: widget.isSelected ? Color(0xffe1bee7) : Color(0xfff3e5f5),
          blurRadius: 20.0,
        ),
      ]),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: widget.isSelected ? Colors.purpleAccent : Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: <Widget>[
              Icon(widget.icon,color: widget.isSelected ? Colors.white : Colors.grey,),
              SizedBox(height: 5.0,),
              Text(widget.headline,style: TextStyle(color: widget.isSelected ? Colors.white : Colors.grey,fontSize: 12.0,),maxLines: 1,textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    ),
    );
  }
}