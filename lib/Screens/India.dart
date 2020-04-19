import 'package:flutter/material.dart';
import 'package:gocorona/Screens/DistrictReport.dart';
import 'package:gocorona/Services/ireports.dart';
import 'package:gocorona/Models/IndiaModel.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import '../Services/ireports.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  List<States>  _filteredReports;
  List<StateWiseConfirmed> reports,stateWiseConfirmed;
  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
    List<States> _temp = await IReport().getStats();
    List<StateWiseConfirmed> _stateCase =await IReport().getStateWiseTotalCases();
    setState(() {
      _filteredReports = _temp;
      reports = _stateCase;
      stateWiseConfirmed = _stateCase;
    });
  }
int stateIndex(String state){
    int index = 0;
    for (index = 0 ; index<_filteredReports.length; index++)
      if(state == _filteredReports[index].state)
        break;
    return index;
  }
  @override
 Widget build(BuildContext context) {
    return _filteredReports != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'India Report',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0.0,
            ),
            body: Column(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(45.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child:Container(
                              height: 40.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: TextField(
                              
                                decoration: InputDecoration(
                                  hintText: "\t\t\tSearch",
                                  suffixIcon: Icon(Icons.search)
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    stateWiseConfirmed = reports
                                        .where((r) => (r.state
                                            .toLowerCase()
                                            .contains(text.trim().toLowerCase())))
                                        .toList();
                                  });
                                },
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        
                        Container(
                          child: Text("[+${stateWiseConfirmed[0].deltaconfirmed}] \nConfimed: \n${stateWiseConfirmed[0].confirmed}",
                          style: TextStyle(color: Colors.red, fontSize: 16.0),
                          textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.redAccent)
                          ),
                          width: 100.0,
                          height: 60.0,
                        ),
                        Container(
                          child: Text("Active: \n${stateWiseConfirmed[0].active}",
                          style: TextStyle(color: Colors.blue, fontSize: 16.0),
                          textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)
                          ),
                          width: 100.0,
                          height: 60.0,
                        ),
                      ],),
                      SizedBox(height: 6.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        Container(
                          child: Text("[+${stateWiseConfirmed[0].deltarecovered}] \nRecovered: \n${stateWiseConfirmed[0].recovered}", 
                            style: TextStyle(color: Colors.green, fontSize: 16.0), 
                            textAlign: TextAlign.center,),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)
                          ),
                          width: 100.0,
                          height: 60.0,
                        ),
                        
                        Container(
                          child: Text("[+${stateWiseConfirmed[0].deltadeaths}] \nDeceased: \n${stateWiseConfirmed[0].deaths}" , style: TextStyle(color: Colors.black87, fontSize: 16.0),textAlign: TextAlign.center,),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                          ),width: 100.0,
                          height: 60.0,
                        ),
                        
                      ],),
                      
                  ],
                ),
                SizedBox(height: 8.0,),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    
                    Text("State/UT", style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text("C", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    Text("A", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                    Text("R", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                    Text("D", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)),
                  ],)
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _filteredReports.length,
                    itemBuilder: (BuildContext context, int index) {
                      index+=1;
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DistrictReport(lst: _filteredReports[stateIndex(stateWiseConfirmed[index].state)].districtdata, state: _filteredReports[stateIndex(stateWiseConfirmed[index].state)].state,)));
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(stateWiseConfirmed[index].state, textAlign: TextAlign.left,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  (int.parse(stateWiseConfirmed[index].deltaconfirmed) > 0 ?
                                  Row(children: <Widget>[
                                    Icon(Icons.arrow_upward, size: 10, color: Colors.red,),
                                    Text(
                                      "${stateWiseConfirmed[index].deltaconfirmed}",
                                      style: TextStyle(fontSize: 10.0, color: Colors.red),
                                      textAlign: TextAlign.center,
                                  )]):Container()
                                  ),
                                  Text(
                                    "${stateWiseConfirmed[index].confirmed}",
                                    style: TextStyle(fontSize: 13.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                                Text(
                                    "${stateWiseConfirmed[index].active}",
                                    style: TextStyle(fontSize: 13.0),
                                    textAlign: TextAlign.center,
                                ),
                                Row(
                                children: <Widget>[
                                  (int.parse(stateWiseConfirmed[index].deltarecovered)> 0 ?
                                  Row(children: <Widget>[
                                    Icon(Icons.arrow_upward, size: 10, color: Colors.green),
                                    Text(
                                      "${stateWiseConfirmed[index].deltarecovered}",
                                      style: TextStyle(fontSize: 10.0, color: Colors.green),
                                      textAlign: TextAlign.center,
                                  )]):Container()
                                  ),
                                  Text(
                                    "${stateWiseConfirmed[index].recovered}",
                                    style: TextStyle(fontSize: 13.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),Row(
                                children: <Widget>[
                                  (int.parse(stateWiseConfirmed[index].deltadeaths) > 0 ?
                                  Row(children: <Widget>[
                                    Icon(Icons.arrow_upward, size: 10, color: Colors.grey),
                                    Text(
                                      "${stateWiseConfirmed[index].deltadeaths}",
                                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                  )]):Container()
                                  ),
                                  Text(
                                    "${stateWiseConfirmed[index].deaths}",
                                    style: TextStyle(fontSize: 13.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              
                            ],
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

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height-5);

    var firstEndPoint = Offset(size.width * .5, size.height - 30.0);
    var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    
    var secondEndPoint = Offset(size.width, size.height - 80.0);
    var secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}