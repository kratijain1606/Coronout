import 'package:flutter/material.dart';

class Around extends StatefulWidget {
  @override
  _AroundState createState() => _AroundState();
}

class _AroundState extends State<Around> {

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
          'Around',
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