
import 'package:gocorona/Services/reports.dart';
import 'package:gocorona/Widgets/chart.dart';
import 'package:gocorona/Widgets/details.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {

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
          'Update',
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