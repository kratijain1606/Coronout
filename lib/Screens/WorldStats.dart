import 'package:gocorona/Models/worldmodel.dart';
import 'package:gocorona/Services/reports.dart';
import 'package:gocorona/Widgets/chart.dart';
import 'package:gocorona/Widgets/details.dart';
import 'package:flutter/material.dart';

class WorldStats extends StatefulWidget {
  @override
  _WorldStatsState createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> {
  Report _report;
  int fallback = 0;

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
    Report _temp = await getReport();

    setState(() {
      _report = _temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: _report != null
          ? SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PieChartSample2(_report),
                      _report.updatedDate != null
                          ? Text(
                              'Last Updated - ${_report.updatedDate} ${_report.updatedTime}',
                              style: Theme.of(context).textTheme.overline,
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 16.0,
                      ),
                      Details(report: _report),
                      
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Image(
                image: new AssetImage("assets/images/loader.gif"),
                height: 100,
                width: 100,
              ),
            ),
    );
  }
}