import 'package:flutter/material.dart';

class AppBarWidget {


  static AppBar header(BuildContext context,String title){

    return AppBar(
      primary: false,
      centerTitle: false,
      title: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(title),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 23.0,
                backgroundImage: NetworkImage(
                    'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigateToPreviousPage(context);
            }),
      ),
      flexibleSpace: Image(
        image: AssetImage('images/tool_bar_bg.png'),
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );

  }


  static void navigateToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }
}
