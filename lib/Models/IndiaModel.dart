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

class StateWiseConfirmed{
  String active;
	String confirmed;
	String deaths;
	String deltaconfirmed;
	String deltadeaths;
	String deltarecovered;
	String lastupdatedtime;
	String recovered;
	String state;
	String statecode;
	String statenotes;
  StateWiseConfirmed({
    this.confirmed, this.deaths, this.recovered, this.active, this.state ,this.deltaconfirmed, this.deltadeaths, this.deltarecovered
  });
}