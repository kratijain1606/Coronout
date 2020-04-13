import 'dart:core';

class States{
  String state;
  List<Districts> districtdata;
  States({this.state, this.districtdata});
}
class Districts{
  String district;
  int confirmed;
  Districts({this.district, this.confirmed});
}