import 'package:flutter/material.dart';
// import 'package:gocorona/Screens/Around.dart';
// import 'package:gocorona/Screens/Emergency.dart';
import 'package:gocorona/Screens/Home.dart';
import 'package:gocorona/Screens/IndiaStats.dart';
import 'package:gocorona/Screens/Update.dart';
import 'package:gocorona/Screens/WorldStats.dart';


import 'package:gocorona/Screens/SymptomsPage.dart';
import 'package:gocorona/Screens/PreventionPage.dart';

import 'package:gocorona/Screens/Require.dart';

import 'package:gocorona/Screens/Help.dart';

void main() => runApp(Gocorona());

class Gocorona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      routes: {
        // '/': (context) => World(),
        '/reports': (context) => WorldStats(),
        '/symptoms': (context) => SymptomsPage(),
        '/prevention': (context) => PreventionPage(),
        '/requirements': (context) => Require(),
        '/countryReport': (context) => WorldStats(),
      },
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  List<Widget> _widgetOptions = [

    //Around(),
   Help(),
    Update(),
    Home(),
    WorldStats(),
    IndiaStats(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      
    Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          /*BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            title: Text('Around'),
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            title: Text('Emergency'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            title: Text('Updates'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('World'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('India'),
          ),
          
        ],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(size: 40, color: Colors.blueAccent),
      ),

      
    );
    
      
      
      
    //  return  Container(width:0.0,height:0.0);
       }
}