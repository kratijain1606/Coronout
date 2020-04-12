import 'dart:convert';

import 'package:gocorona/Models/IndiaModel.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

final String link = "https://api.covid19india.org/v2/state_district_wise.json";

Future<DistrictData> getDistrictData() async {
  DistrictData districtData;
  DateFormat timeFormatter = DateFormat().add_jm();

  try {
    Response response = await get(link + "all");
    Map data = jsonDecode(response.body);
    districtData = new DistrictData(
      state: data["state"],
      district: data["districtData"]["district"],
      confirmed: data["districtData"]["confirmed"],
      lastUpdatedTime: timeFormatter
          .format(DateTime.fromMillisecondsSinceEpoch(data["districtData"]["lastupdatedtime"])),
      deltaConfirmed: data["districtData"]["delta"]["confirmed"],
    );
    print(data);
  } catch (e) {
    print("Exception Caught at getDistrictData() $e");
  }

  return districtData;
}
