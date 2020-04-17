import 'package:gocorona/Widgets/homeNavItems.dart';
import 'package:gocorona/Widgets/Requirements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocorona/Screens/DocBot.dart';
import 'package:gocorona/Screens/SymptomsChecker.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width,
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
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          height: 0.08 * height,
                          width: 0.43 * width,
                          child: ListTile(
                            leading: Container(
                              child: new CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/doc.png"),
                                radius: 24.0,
                              ),
                              padding: const EdgeInsets.all(1.5), // borde width
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DocBot()));
                            },
                            title: Text(
                              "Ask Mrs. Doc Bot",
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          height: 0.08 * height,
                          width: 0.43 * width,
                          child: ListTile(
                            trailing: Container(
                              child: new CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/symptomschecker.png"),
                                radius: 24.0,
                              ),
                              padding: const EdgeInsets.all(1.5), // borde width
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SymptomsChecker()));
                            },
                            title: Text(
                              "Symptom Checker",
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 0.1*height),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Requirements",
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Help you to prevent viruses better",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Requirements(),
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
