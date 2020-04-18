import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'main.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  double currentIndexPage;
  int pageLength;

  void initState() {
    currentIndexPage = 0;
    pageLength = 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          children: <Widget>[
            Walkthrougth(textContent: "ॐ सर्वे भवन्तु सुखिनः \nसर्वे सन्तु निरामयाः । \nसर्वे भद्राणि पश्यन्तु \nमा कश्चिद्दुःखभाग्भवेत् । \nॐ शान्तिः शान्तिः शान्तिः ॥", imageSrc: "prayinghand"),
            Walkthrougth(textContent: "Coronout = Corona + burnout \nThe mental anguish one feels \nfrom hearing about the \nCoronavirus every minute \nof the day.", imageSrc: "doctor"),
            Walkthrougth(textContent: "It got Symptoms Checker, \nAnd Mrs. Doc Bot \nTo help you \nStay Safe and Healthy", imageSrc: "doctors"),
            Walkthrougth(textContent: "Also keep you Update \nwith regular news \nand stats from the world", imageSrc: "stats"),
            Walkthrougth(textContent: "You can also donate \nCheck nearbys \nContact in crisis", imageSrc: "donate"),
            Walkthrougth(textContent: "Get Ready to boost-up", imageSrc: "welcome"),
          ],
          onPageChanged: (value) {
            setState(() => currentIndexPage = value.toDouble());
          },
        ),
        if(currentIndexPage == 5)
          Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35),
            child: Align(
              alignment: Alignment.centerRight,
              child: new RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                        "Enter!",
                        style: new TextStyle(color: Colors.white),
                      ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyStatefulWidget()));  
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35),
            child: Align(
              alignment: Alignment.centerRight,
              child: new DotsIndicator(
                  dotsCount: pageLength,
                  position: currentIndexPage,
                  decorator: DotsDecorator(
                    color: Colors.blueAccent,
                    activeColor: Colors.deepOrange,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class Walkthrougth extends StatelessWidget {
  final String textContent;
  final String imageSrc;
  Walkthrougth({Key key, @required this.textContent, @required this.imageSrc }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white70),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
          Image(
            image: AssetImage("assets/images/$imageSrc.png"),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width * 0.12,),
              Text(
                textContent,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueAccent),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
            ],
          ),    
        ],
      )
    );
  }
}