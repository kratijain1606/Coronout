import 'package:gocorona/Models/IndiaModel.dart';
import 'package:gocorona/Services/IndiaData.dart';
import 'package:gocorona/Widgets/chart.dart';
import 'package:gocorona/Widgets/details.dart';
import 'package:flutter/material.dart';

class IndiaStats extends StatefulWidget {
  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  DistrictData districtData;
  int fallback = 0;

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
    DistrictData _temp = await getDistrictData();

    setState(() {
      districtData = _temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DistrictDatas',
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                              'Confirmed State - ${districtData.state}',
                              style: Theme.of(context).textTheme.overline,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          /*:Center(
              child: Image(
                image: new AssetImage("assets/images/loader.gif"),
                height: 100,
                width: 100,
              ),
            ),*/
    );
  }
}