import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SymptomsItems extends StatefulWidget {
  @override
  _SymptomsItemsState createState() => _SymptomsItemsState();
}

class _SymptomsItemsState extends State<SymptomsItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getSymptomsItems(context, 'High Fever', 'fever'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(context, 'Dry Cough', 'drycough'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(context, 'Tiredness', 'tiredness'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(context, 'Difficulty in Breathing', 'shortness'),
        SizedBox(
          height: 18.0,
        ),
      ],
    );
  }
}

class PreventionItems extends StatefulWidget {
  @override
  _PreventionItemsState createState() => _PreventionItemsState();
}

class _PreventionItemsState extends State<PreventionItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getSymptomsItems(context, 'Wash hands often', 'wash'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(context, 'Cough into elbow', 'elbow'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(
            context, "Don't touch your face frequently", 'notouchface'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(context, 'Keep safe distance', 'safedistance'),
        SizedBox(
          height: 18.0,
        ),
        getSymptomsItems(context, 'Stay home if you can', 'home'),
        SizedBox(
          height: 18.0,
        ),
      ],
    );
  }
}

Widget getSymptomsItems(BuildContext context, String text, String imgSrc) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: Container(
        child: new CircleAvatar(
          backgroundImage: AssetImage("assets/images/$imgSrc.JPG"),
          radius: 25.0,
        ),
      ),
      title: Text(
        text,
        style:
            Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
      ),
      trailing: Icon(
        Icons.done,
        color: Colors.redAccent,
      ),
    ),
  );
}

void launchUrl() async {
  const url = 'https://www.who.int/news-room/q-a-detail/q-a-coronaviruses';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
