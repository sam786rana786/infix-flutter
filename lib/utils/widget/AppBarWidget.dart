import 'package:flutter/material.dart';
import 'package:infixedu/utils/Utils.dart';


class AppBarWidget {


  static PreferredSize header(BuildContext context,String title){

    return PreferredSize(
      preferredSize: Size(double.infinity, 40.0), // 40 is the height
      child: AppBar(
        primary: false,
        centerTitle: false,
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(title,style: TextStyle(fontSize: 20.0),),
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
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigateToPreviousPage(context);
              }),
        ),
        flexibleSpace: Image(
          image: AssetImage('images/tool_bar_bg.png'),
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );

  }

  static void navigateToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }
}
