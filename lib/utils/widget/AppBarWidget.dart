import 'package:flutter/material.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:infixedu/screens/Login.dart';


class AppBarWidget {


  static AppBar header(BuildContext context,String title){

    return AppBar(
      primary: false,
      centerTitle: false,
      title: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(title),
              ),
        FutureBuilder(
          future:  Utils.getStringValue('image'),
          builder: (BuildContext context,AsyncSnapshot<String> snapshot){

            if(snapshot.hasData){
              Utils.saveStringValue('image', snapshot.data);
              return Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(snapshot.data),
                    backgroundColor: Colors.transparent,
                  ),
                );
            }else{
              return Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                    backgroundColor: Colors.transparent,
                  ),
                );
            }
          },
        ),
            ],
          ),
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
