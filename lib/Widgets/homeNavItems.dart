import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeNavItems extends StatefulWidget {
  @override
  _HomeNavItemsState createState() => _HomeNavItemsState();
}

class _HomeNavItemsState extends State<HomeNavItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            getHomePageNavItems(
                context: context,
                icon: Icons.mood_bad,
                title: 'Symptoms',
                subTitle: 'Signs to Identify the risk of Infection',
                navigate: 'symptoms'),
            SizedBox(
              width: 16.0,
            ),
            getHomePageNavItems(
                context: context,
                icon:Icons.local_hospital,
                
                title: 'Prevention',
                subTitle: 'Help you to avoid getting infected',
                navigate: 'prevention'
                ),
          ],
        ),
        SizedBox(
          height:30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            getHomePageNavItems(
                context: context,
                icon: Icons.insert_chart,
                title: 'Reports',
                subTitle: 'Data and info related to the disease',
                navigate: 'reports'
                ),
            SizedBox(
              width: 16.0,
            ),
            getHomePageNavItems(
                context: context,
                icon:Icons.check_box,
                // icon: FontAwesomeIcons.globeAmericas,
                title: 'Requirements',
                
                subTitle:   "Help you to prevent viruses better",
                navigate: 'requirements'),
          ],
        ),
        SizedBox(
          height: 50.0,
        )
      ],
    );
  }
}

Widget getHomePageNavItems(
    {BuildContext context, IconData icon, String title, String subTitle, String navigate}) {
  return Expanded(
    child: InkWell(
      onTap: (){
        navigate != null ? Navigator.pushNamed(context, '/$navigate') : print("No where to go") ;
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Color(0xFFB5EBF5),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 17.0,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                  fontSize: 15.0),
            ),
          ],
        ),
      ),
    ),
  );
}
