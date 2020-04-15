import 'package:flutter/material.dart';

class DocBot extends StatefulWidget {
  @override
  _DocBotState createState() => _DocBotState();
}

class _DocBotState extends State<DocBot> {

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
          'Mrs. Doc Bot',
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