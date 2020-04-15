import 'package:flutter/material.dart';

class SymptomsChecker extends StatefulWidget {
  @override
  _SymptomsCheckerState createState() => _SymptomsCheckerState();
}

class _SymptomsCheckerState extends State<SymptomsChecker> {

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Symptoms Checker',
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
   );
  }
} 