import 'dart:convert';
import 'package:http/http.dart';
import 'package:gocorona/Models/indiamodel.dart';

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
}
