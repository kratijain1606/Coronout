
import 'package:flutter/material.dart';
import 'package:gocorona/Widgets/homeNavItems.dart';
import 'package:gocorona/Widgets/requirements.dart';
class Help extends StatefulWidget{
_Help createState() => _Help();
}


class _Help extends State<Help>{
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text('Help',
      style: Theme.of(context).textTheme.title,),
       backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
    ),
    body:  SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 1000,
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            HomeNavItems(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
