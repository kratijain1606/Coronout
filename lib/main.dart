import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:gocorona/Screens/Around.dart';
import 'package:gocorona/Screens/Home.dart';
import 'package:gocorona/Screens/Login.dart';
import 'package:gocorona/Screens/World.dart';
import 'package:gocorona/Screens/India.dart';
import 'package:gocorona/Screens/SymptomsPage.dart';
import 'package:gocorona/Screens/PreventionPage.dart';
import 'package:gocorona/Screens/Help.dart';
import 'package:gocorona/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; 
import 'dart:io';

import 'package:vibration/vibration.dart'; 

void main() => runApp(Gocorona());

class Gocorona extends StatelessWidget {
  
  Future<int> checkFirstSeen() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool _seen = (prefs.getBool('seen') ?? false);

        if (_seen) 
            return 1;
        print(_seen); 
        await prefs.setBool('seen', true);
        return 0;
    }
  Future<int> checkLogin() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool _login = (prefs.getBool('login') ?? false);
        if (_login) 
            return 1;
        return 0;
    }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/symptoms': (context) => SymptomsPage(),
        '/prevention': (context) => PreventionPage(),
        '/homepage': (context) => MyStatefulWidget(),    
        '/loginpage': (context) => Login(),        
      },
      home: checkFirstSeen() != 1 ? checkLogin() !=1 ? Login() : MyStatefulWidget() : Welcome(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  scanForDevices(){
    print("Scan");
    flutterBlue.startScan();
    
    print("Started Scan");
    var subscriptions = flutterBlue.scanResults.listen((results) {
      
        print("Results: -");
        for (ScanResult r in results) {
            print('${r.device.id} found! rssi: ${r.rssi} ');
            alertUsingVibrations(r.rssi,-69);
        }
    });
    print(subscriptions);
        
  }
  alertUsingVibrations(int rssi, int txPower){
    //social distancing
    double distance = pow(10, ((txPower-rssi)/(10*2)));
    print(distance);
    if (distance <= 1.8){ 
      print("vibrating");
      Vibration.vibrate(pattern: [100, 2000, 100, 2000], intensities: [128, 150]);
      AlertDialog(
        title: Text("Social Distancing Alert"),
        content: Text("Pls Maintain a distance of 6ft."),
        backgroundColor: Colors.amberAccent,
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () { 
              Vibration.cancel();
            },
          ),
        ],
      );
    }
    else{
      Vibration.cancel();
    }
  }
  ///Initialisation and listening to device state
  void initState() {
      super.initState();
      print("here");
      flutterBlue.state.listen((state) {
      if (state == BluetoothState.off) {
        //Alert user to turn on bluetooth.
        AlertDialog(
          title: Text("Turn on Bluetooth"),
          content: Text("Turn on bluetooth for social distancing alert."),
          backgroundColor: Colors.lightBlue,
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () { 
                Vibration.cancel();
              },
            ),
          ],
        );
      }
      else if (state == BluetoothState.on) {
        print("Bluetooth On");
        scanForDevices(); 
      }
    });
  }
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
