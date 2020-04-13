import 'dart:core';
class DistrictData {
  String state;
  String district;
  int confirmed;
  String lastUpdatedTime;
  int deltaConfirmed;

  DistrictData(
    {
      this.state,
      this.district,
      this.confirmed,
      this.lastUpdatedTime,
      this.deltaConfirmed
    }
  );
}