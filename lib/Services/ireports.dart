import 'dart:convert';
import 'package:gocorona/Models/IndiaModel.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

final String link = "https://api.covid19india.org/v2/state_district_wise.json";

class IReport {
  Future<List<States>> getStats() async {
    List<States> reports = [];
    try {
      Response response = await get(link);
      List data = jsonDecode(response.body);
      print(data);
      for (int i = 0; i < data.length; i++) {
        List lst = jsonDecode(jsonEncode(data[i]["districtData"]));
        List<Districts> distlist = [];
        for(int j = 0;j<lst.length; j++){
           Districts _districts = new Districts(
            district: lst[j]["district"],
            confirmed: lst[j]["confirmed"]
          );
          distlist.add(_districts);
        }
        States _report = new States(
            state: data[i]["state"],
            districtdata: distlist,
            );
        reports.add(_report);
      }
    } catch (e) {
      print("Error");
      print(e);
    }
    return reports;
  }
Future<List<StateWiseConfirmed>> getStateWiseTotalCases() async {
    List<StateWiseConfirmed> reports =[];
    String link = "https://api.covid19india.org/data.json";
    try {
      Response response = await get(link);
      Map<String,dynamic> data = jsonDecode(response.body);
      List cases = data["statewise"];
      print(cases);
      for (int i = 0; i<cases.length; i++){
        StateWiseConfirmed report = new StateWiseConfirmed(
          confirmed : cases[i]["confirmed"],
          deaths : cases[i]["deaths"],
          recovered : cases[i]["recovered"],
          active: cases[i]["active"],
          state : cases[i]["state"],
          deltaconfirmed: cases[i]["deltaconfirmed"],
          deltadeaths: cases[i]["deltadeaths"],
          deltarecovered: cases[i]["deltarecovered"]
        );
        print(report);
        reports.add(report);
      }
      print(reports[1].deaths);
    } catch (e) {
      print("Error5");
      print(e);
    }
    return reports;
  }
}
