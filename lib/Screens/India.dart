import 'package:flutter/material.dart';
import 'package:gocorona/Screens/DistrictReport.dart';
import 'package:gocorona/Services/ireports.dart';
import 'package:gocorona/Models/indiamodel.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  List<States> reports, _filteredReports;
  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
        List<States> _temp = await IReport().getStats();
    setState(() {
      reports = _temp;
      _filteredReports = reports;
    });
  }

  @override
 Widget build(BuildContext context) {
    return reports != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'States',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0.0,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            border: OutlineInputBorder(),
                            labelText: "Search",
                            suffixIcon: Icon(Icons.search),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _filteredReports = reports
                                  .where((r) => (r.state
                                      .toLowerCase()
                                      .contains(text.trim().toLowerCase())))
                                  .toList();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _filteredReports.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DistrictReport(lst: _filteredReports[index].districtdata, state: _filteredReports[index].state,)));
                          },
                          title: Text(_filteredReports[index].state),
                          trailing: Icon(
                            Icons.open_in_new,
                            color: Color(0xFF1E3CFF),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ))
        : Scaffold(
            body: Center(
              child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: Colors.blue,),
            ),
          );
  }
} 