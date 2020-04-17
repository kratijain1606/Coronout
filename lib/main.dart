import 'package:flutter/material.dart';
import 'package:gocorona/Screens/Around/Around.dart';
import 'package:gocorona/Screens/Home/Home.dart';
import 'package:gocorona/Screens/World/World.dart';
import 'package:gocorona/Screens/India/India.dart';
import 'package:gocorona/Screens/Help/SymptomsPage.dart';
import 'package:gocorona/Screens/Help/PreventionPage.dart';
import 'package:gocorona/Screens/Help/Help.dart';

void main() => runApp(Gocorona());

class Gocorona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/symptoms': (context) => SymptomsPage(),
        '/prevention': (context) => PreventionPage(),
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
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  List<Widget> _widgetOptions = [Help(), Around(), Home(), India(), World()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Help'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            title: Text('Around'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('India'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            title: Text('World'),
          ),
        ],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(size: 40, color: Colors.blue),
      ),
    );
  }
}
