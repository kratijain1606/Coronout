import 'package:gocorona/Models/indiamodel.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class DistrictReport extends StatefulWidget {
  final List<Districts> lst;
  final String state;
  DistrictReport({this.lst, this.state});
  @override
  _DistrictReportState createState() => _DistrictReportState();
}

class _DistrictReportState extends State<DistrictReport> {
  List<Districts> _filteredReports;
  @override
  Widget build(BuildContext context) {
    return widget.lst != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                widget.state,
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
                              _filteredReports = widget.lst
                                  .where((r) => (r.district
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
                _filteredReports!=null? 
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _filteredReports.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                            title: Text(_filteredReports[index].district),
                            trailing: Text("Cases: " +
                                _filteredReports[index].confirmed.toString())),
                      );
                    },
                  ),
                ) : 
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: widget.lst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                            title: Text(widget.lst[index].district),
                            trailing: Text("Cases: " +
                                widget.lst[index].confirmed.toString())),
                      );
                    },
                  ))
              ],
            ))
        : Scaffold(
            body: Center(
              child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: Colors.blue,),
            ),
          );
  }
}
